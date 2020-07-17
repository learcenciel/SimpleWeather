//
//  WeeklyWeatherForecast.swift
//  SimpleWeather
//
//  Created by Alexander on 25.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import UIKit

struct WeeklyHourlyWeatherForecast {
    let weekDayName: String
    let currentDayTemperature: Float
    let weatherIconType: WeatherIconType
    var weatherIcon: UIImage {
        return UIImage(named: weatherIconType.rawValue) ?? UIImage(named: "test_icon")!
    }
    let currentDayAdditionalInfo: CurrentAdditionalInfo
    let currentDayHourlyInfo: [CurrentDayHourlyTemperatureInfo]
    let weekDayItem: WeekDayItem
}

struct CurrentDayHourlyTemperatureInfo {
    let hourTime: Date
    let temperature: Float
    let temperatureDescription: String
}
