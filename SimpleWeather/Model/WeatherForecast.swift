//
//  WeatherForecast.swift
//  SimpleWeather
//
//  Created by Alexander on 25.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import CoreData
import Foundation
import UIKit

enum WeatherIconType: String {
    case clear, atmosphere, clouds, rain, thunderStorm, snow, drizzle
    case mainClouds, mainClear, mainAtmosphere, mainSnow,
    mainRain, mainDrizzle, mainThunderstorm
}

struct WeatherForecast {
    let countryName: String
    var cityName: String
    let timeZone: Int
    let currentTemperature: Float
    let weatherIconType: WeatherIconType
    var weatherIcon: UIImage {
        return UIImage(named: weatherIconType.rawValue) ?? UIImage(named: "test_icon")!
    }
    let futureDays: [TemperatureInfo]
    let currentAdditionalInfo: CurrentAdditionalInfo
    let sunrise: Date
    let sunset: Date
}

struct CurrentAdditionalInfo {
    let windSpeed: Float
    let windDegree: Float
    let humidity: Float
    let pressure: Float
}

struct TemperatureInfo {
    let time: Int
    let weatherIconType: WeatherIconType
    var weatherIcon: UIImage {
        return UIImage(named: weatherIconType.rawValue) ?? UIImage(named: "test_icon")!
    }
    let temperature: Float
}
