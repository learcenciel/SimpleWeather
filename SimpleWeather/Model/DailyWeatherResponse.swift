//
//  DailyWeatherResponse.swift
//  SimpleWeather
//
//  Created by Alexander on 25.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct DailyWeatherResponse: Decodable {
    let cityName: String
    let systemInfo: SystemInfo
    let windInfo: WindInfo
    let mainInfo: MainInfo
    let weatherDescription: [WeatherDescription]
    let coordInfo: CoordInfo
    let timeZone: Int
    
    private enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case systemInfo = "sys"
        case windInfo = "wind"
        case mainInfo = "main"
        case weatherDescription = "weather"
        case coordInfo = "coord"
        case timeZone = "timezone"
    }
}

struct CoordInfo: Decodable {
    let lat: Float
    let lon: Float
    
    private enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
}

struct SystemInfo: Decodable {
    let countryName: String
    let sunrise: Int
    let sunset: Int
    
    private enum CodingKeys: String, CodingKey {
        case countryName = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}

struct WindInfo: Decodable {
    let windSpeed: Float
    let windDeg: Float
    
    private enum CodingKeys: String, CodingKey {
        case windSpeed = "speed"
        case windDeg = "deg"
    }
}

struct MainInfo: Decodable {
    let currentTemperature: Float
    let currentPressure: Float
    let currentHumidity: Float
    
    private enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case currentPressure = "pressure"
        case currentHumidity = "humidity"
    }
}

struct WeatherDescription: Decodable {
    let weatherId: Int
    let weatherType: String
    let weatherDescription: String
    let weatherIcon: String
    
    private enum CodingKeys: String, CodingKey {
        case weatherId = "id"
        case weatherType = "main"
        case weatherDescription = "description"
        case weatherIcon = "icon"
    }
}
