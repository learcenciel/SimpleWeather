//
//  WeeklyHourlyWeatherResponse.swift
//  SimpleWeather
//
//  Created by Alexander on 25.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct WeeklyHourlyWeatherResponse: Decodable {
    let hourlyTemperatureList: [HourlyTemperatureInfo]
    
    private enum CodingKeys: String, CodingKey {
        case hourlyTemperatureList = "list"
    }
}

struct HourlyTemperatureInfo: Decodable {
    let timeStamp: Int
    let temperatureInfo: MainInfo
    let weatherInfo: [WeatherDescription]
    let windInfo: WindInfo
    
    private enum CodingKeys: String, CodingKey {
        case timeStamp = "dt"
        case temperatureInfo = "main"
        case weatherInfo = "weather"
        case windInfo = "wind"
    }
}
