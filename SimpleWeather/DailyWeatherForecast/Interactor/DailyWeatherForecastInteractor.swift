//
//  DailyWeatherForecastInteractor.swift
//  SimpleWeather
//
//  Created by Alexander on 26.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class DailyWeatherForecastInteractor: DailyWeatherForecastInteractorProtocol {
    
    var presenter: DailyWeatherForecastPresenterProtocol!
    var httpClient: WeatherAPI
    var modelConverter: WeatherForecastConverter
    
    init(httpClient: WeatherAPI,
         modelConverter: WeatherForecastConverter) {
        self.httpClient = httpClient
        self.modelConverter = modelConverter
    }
    
    func retreiveDailyWeatherForecast(lat: Float, lon: Float) {
        httpClient.fetchCurrentWeather(
            parameters: ["lat": lat,
                         "lon": lon, "units": "metric"],
            completionHandler: { dailyWeatherResult in
                switch dailyWeatherResult {
                case .success(let dailyWeatherResponse):
                    self.httpClient.fetchCurrentHourlyWeather(
                        parameters: ["lat": lat,
                                     "lon": lon, "units": "metric"],
                        completionHandler: { dailyWeeklyHourlyResult in
                            switch dailyWeeklyHourlyResult {
                            case .success(let dailyWeeklyHourlyResponse):
                                let weatherForecast =
                                    self.modelConverter.convertWeatherForecast(dailyWeatherResponse,
                                                                           dailyWeeklyHourlyResponse)
                                self.didRetreieveWeatherForecastFromNetwork(weatherForecast)
                            case .failure(let err):
                                print(err)
                            }
                    })
                case .failure(let err):
                    print(err)
                }
        })
    }
    
    func didRetreieveWeatherForecastFromNetwork(_ weatherForecast: WeatherForecast?) {
        if let weatherForecast = weatherForecast {
            presenter.didRetreiveWeatherForecast(weatherForecast)
        }
    }
}
