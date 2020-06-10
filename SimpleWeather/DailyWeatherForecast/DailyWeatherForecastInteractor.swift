//
//  DailyWeatherForecastInteractor.swift
//  SimpleWeather
//
//  Created by Alexander on 26.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import CoreLocation
import Foundation

class DailyWeatherForecastInteractor: NSObject, DailyWeatherForecastInteractorProtocol {
    
    var locationManager: CoreLocationManager!
    var presenter: DailyWeatherForecastPresenterProtocol!
    var httpClient: WeatherAPI
    var modelConverter: WeatherForecastConverter
    
    var locations: [CLLocation]?
    
    var isComplete = false
    
    init(httpClient: WeatherAPI,
         modelConverter: WeatherForecastConverter) {
        self.httpClient = httpClient
        self.modelConverter = modelConverter
    }
    
    func retreiveDailyWeatherForecast() {
        locationManager.getCurrentLocation()
    }
    
    func retreiveCurrentDailyWeatherForecast() {
        guard let lat = locations?.first?.coordinate.latitude,
            let lon = locations?.first?.coordinate.longitude
            else { return }
        
        if isComplete { return }
        
        isComplete = true
        
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
                                self.isComplete = false
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
            self.presenter.didRetreiveWeatherForecast(weatherForecast)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locations = locations
        self.retreiveCurrentDailyWeatherForecast()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
