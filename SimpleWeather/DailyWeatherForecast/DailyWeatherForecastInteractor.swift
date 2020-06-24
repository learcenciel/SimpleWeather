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
    
    var isFetchComplete = false
    
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
        self.locationManager.requestCurrentLocation()
    }
    
    func retreiveCurrentDailyWeatherForecast(_ cityName: String?, _ locations: [CLLocation]?, isCurrent: Bool) {
        guard let coords = locations?.first?.coordinate else { return }
        
        httpClient.fetchCurrentWeather(
            parameters: ["lat": coords.latitude,
                         "lon": coords.longitude,
                         "units": "metric"],
            completionHandler: { dailyWeatherResult in
                switch dailyWeatherResult {
                case .success(let dailyWeatherResponse):
                    self.fetchCurrentHourlyWeatherForecast(coords: coords,
                                                      dailyWeatherResponse: dailyWeatherResponse,
                                                      cityName: cityName,
                                                      isCurrent: isCurrent)
                case .failure(let err):
                    print(err)
                }
        })
    }
    
    func fetchCurrentHourlyWeatherForecast(coords: CLLocationCoordinate2D,
                                           dailyWeatherResponse: DailyWeatherResponse,
                                           cityName: String?,
                                           isCurrent: Bool) {
        self.httpClient.fetchCurrentHourlyWeather(
            parameters: ["lat": coords.latitude,
                         "lon": coords.longitude,
                         "units": "metric"],
            completionHandler: { dailyWeeklyHourlyResult in
                switch dailyWeeklyHourlyResult {
                case .success(let dailyWeeklyHourlyResponse):
                    var weatherForecast =
                        self.modelConverter.convertWeatherForecast(dailyWeatherResponse,
                                                                   dailyWeeklyHourlyResponse)
                    let cityName = cityName != nil ? cityName : weatherForecast.cityName
                    self.saveCitiesToDatabase(cityName!,
                                              lattitude: Double(coords.latitude),
                                              longitude: Double(coords.longitude),
                                              isCurrent: isCurrent)
                    weatherForecast.cityName = cityName!
                    self.didRetreieveWeatherForecastFromNetwork(weatherForecast)
                    self.isFetchComplete = false
                case .failure(let err):
                    print(err)
                }
        })
    }
    
    func saveCitiesToDatabase(_ weatherCityName: String,
                              lattitude: Double,
                              longitude: Double,
                              isCurrent: Bool) {
        databaseManager.saveCity(weatherCityName,
                                 lattitude: lattitude,
                                 longtitude: longitude, isCurrent: isCurrent)
    }
    
    func didRetreieveWeatherForecastFromNetwork(_ weatherForecast: WeatherForecast) {
        self.presenter.didRetreiveWeatherForecast(weatherForecast)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if isFetchComplete { return }
        
        isFetchComplete = true
        
        if let currentCity = currentUserSession.getCurrentCity() {
            let locations = [currentCity.location]
            self.retreiveCurrentDailyWeatherForecast(currentCity.name, locations, isCurrent: currentCity.isCurrent)
        } else {
            self.retreiveCurrentDailyWeatherForecast(nil, locations, isCurrent: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.retreiveDailyWeatherForecast()
        } else if status == .denied {
            self.presenter.didRetreieveLocationAccessDenied("Please give location determination access in settings")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        
        if let error = error as? CLError {
            presenter.didRetrieveLocationError(error)
        }
    }
}
