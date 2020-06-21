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
    var databaseManager: DatabaseManager
    var currentUserSession: CurrentUserSession
    
    var isComplete = false
    
    init(httpClient: WeatherAPI,
         modelConverter: WeatherForecastConverter,
         databaseManager: DatabaseManager,
         currentUserSession: CurrentUserSession) {
        self.httpClient = httpClient
        self.modelConverter = modelConverter
        self.databaseManager = databaseManager
        self.currentUserSession = currentUserSession
    }
    
    func retreiveDailyWeatherForecast() {
        self.locationManager.getCurrentLocation()
    }
    
    func retreiveCurrentDailyWeatherForecast(_ locations: [CLLocation]?, isCurrent: Bool) {
        
        guard
            let lat = locations?.first?.coordinate.latitude,
            let lon = locations?.first?.coordinate.longitude
        else { return }
        
        if isComplete { return }
        
        isComplete = true
        
        httpClient.fetchCurrentWeather(
            parameters: ["lat": lat,
                         "lon": lon,
                         "units": "metric"],
            completionHandler: { dailyWeatherResult in
                switch dailyWeatherResult {
                case .success(let dailyWeatherResponse):
                    self.httpClient.fetchCurrentHourlyWeather(
                        parameters: ["lat": lat,
                                     "lon": lon,
                                     "units": "metric"],
                        completionHandler: { dailyWeeklyHourlyResult in
                            switch dailyWeeklyHourlyResult {
                            case .success(let dailyWeeklyHourlyResponse):
                                let weatherForecast =
                                    self.modelConverter.convertWeatherForecast(dailyWeatherResponse,
                                                                               dailyWeeklyHourlyResponse)
                                self.didRetreieveWeatherForecastFromNetwork(weatherForecast)
                                self.saveCitiesToDatabase(weatherForecast.cityName,
                                                          lattitude: Float(lat),
                                                          longitude: Float(lon),
                                                          isCurrent: isCurrent)
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
    
    func saveCitiesToDatabase(_ weatherCityName: String,
                              lattitude: Float,
                              longitude: Float,
                              isCurrent: Bool) {
        databaseManager.saveCity(weatherCityName,
                                 lattitude: lattitude,
                                 longtitude: longitude, isCurrent: isCurrent)
    }
    
    func didRetreieveWeatherForecastFromNetwork(_ weatherForecast: WeatherForecast?) {
        if let weatherForecast = weatherForecast {
            self.presenter.didRetreiveWeatherForecast(weatherForecast)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentCity = currentUserSession.currentCity {
            let locations = [CLLocation(latitude: CLLocationDegrees(currentCity.lattitude),
                                        longitude: CLLocationDegrees(currentCity.longtitude))]
            self.retreiveCurrentDailyWeatherForecast(locations, isCurrent: currentCity.isCurrent)
        } else {
            self.retreiveCurrentDailyWeatherForecast(locations, isCurrent: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.retreiveDailyWeatherForecast()
        } else if status == .denied {
            self.presenter.didRetrieveLocationError("Please give location determination access in settings")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        presenter.didRetrieveLocationError(error.localizedDescription)
    }
}
