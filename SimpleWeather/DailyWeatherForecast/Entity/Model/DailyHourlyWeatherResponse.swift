//
//  DailyHourlyWeatherResponse.swift
//  SimpleWeather
//
//  Created by Alexander on 25.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct DailyHourlyWeatherResponse: Decodable {
    
    let hourlyTemperatureList: [HourlyTemperatureList]
    let cityInfo: CityInfo
    
    private enum CodingKeys: String, CodingKey {
        case hourlyTemperatureList = "list"
        case cityInfo = "city"
    }
}

struct HourlyTemperatureList: Decodable {
    let timeStamp: Int
    let temperatureInfo: MainInfo
    let weatherInfo: [WeatherDescription]
    
    private enum CodingKeys: String, CodingKey {
        case timeStamp = "dt"
        case temperatureInfo = "main"
        case weatherInfo = "weather"
    }
}

struct CityInfo: Decodable {
    let timeZone: Int
    
    private enum CodingKeys: String, CodingKey {
        case timeZone = "timezone"
    }
}
