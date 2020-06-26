//
//  WeatherAPI.swift
//  SimpleWeather
//
//  Created by Alexander on 25.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class WeatherAPI {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func fetchCurrentWeather(parameters: [String: Any]?,
                             completionHandler: @escaping(Result<DailyWeatherResponse, HTTPErrors>) -> Void) {
        httpClient.get(url: "https://api.openweathermap.org/data/2.5/weather",
                       parameters: parameters,
                       completionHandler: completionHandler)
    }
    
    func fetchCurrentHourlyWeather(parameters: [String: Any]?,
                                   completionHandler: @escaping(Result<DailyHourlyWeatherResponse, HTTPErrors>) -> Void) {
        httpClient.get(url: "https://api.openweathermap.org/data/2.5/forecast",
                       parameters: parameters,
                       completionHandler: completionHandler)
    }
    
    func fetchWeeklyHourlyWeather(parameters: [String: Any]?,
                                  completionHandler: @escaping(Result<WeeklyHourlyWeatherResponse, HTTPErrors>) -> Void) {
        httpClient.get(url: "https://api.openweathermap.org/data/2.5/forecast", parameters: parameters, completionHandler: completionHandler)
    }
}
