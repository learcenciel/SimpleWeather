//
//  WeeklyWeatherForecastInteractor.swift
//  SimpleWeather
//
//  Created by Alexander on 26.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import CoreLocation
import Foundation

class WeeklyWeatherForecastInteractor: WeeklyWeatherForecastInteractorProtocol {
    var presenter: WeeklyWeatherForecastPresenterProtocol!
    private var httpClient: WeatherAPI
    private var modelConverter: WeeklyWeatherForecastConverter
    private var currentUserSession: CurrentUserSession
    
    private var isFetchComplete = false
    
    init(httpClient: WeatherAPI,
         modelConverter: WeeklyWeatherForecastConverter,
         databaseManager: DatabaseManager,
         currentUserSession: CurrentUserSession) {
        self.httpClient = httpClient
        self.modelConverter = modelConverter
        self.currentUserSession = currentUserSession
    }
    
    func retreiveWeeklyWeatherForecast() {
        guard
            let lattitude = currentUserSession.getCurrentCity()?.lattitude,
            let longtitude = currentUserSession.getCurrentCity()?.longtitude
        else { return }
        
        let coords = CLLocation(latitude: lattitude, longitude: longtitude)
        httpClient.fetchWeeklyHourlyWeather(parameters: ["lat": coords.coordinate.latitude,
                                                         "lon": coords.coordinate.longitude,
                                                         "units": "metric"]) { result in
                                                            switch result {
                                                            case .failure(let err):
                                                                print(err)
                                                            case .success(let weeklyHourlyResponse):
                                                                let weeklyHourlyWeatherForecast = self.modelConverter.convertWeeklyWeatherForecast(weeklyHourlyResponse)
                                                                self.presenter.didRetreiveWeeklyWeatherForecast(weeklyHourlyWeatherForecast)
                                                            }
        }
    }
}
