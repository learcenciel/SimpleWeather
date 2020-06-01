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
    case clearSky, fewClounds, scatteredClouds, brokenClouds,
    showerRain, rain, thunderStorm, snow, mist, drizzle
    case mainClouds
}

struct WeatherForecast {
    let countryName: String
    let cityName: String
    let currentTemperature: String
    let weatherIconType: WeatherIconType
    var weatherIcon: UIImage {
        return UIImage(named: weatherIconType.rawValue) ?? UIImage(named: "test_icon")!
    }
    let futureDays: [TemperatureInfo]
    let currentAdditionalInfo: CurrentAdditionalInfo
}

struct CurrentAdditionalInfo {
    let wind: String
    let windDeg: String
    let humidity: String
    let pressure: String
}

struct TemperatureInfo {
    let time: String
    let weatherIconType: WeatherIconType
    var weatherIcon: UIImage {
        return UIImage(named: weatherIconType.rawValue) ?? UIImage(named: "test_icon")!
    }
    let temperature: String
}
