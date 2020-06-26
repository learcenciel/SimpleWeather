//
//  WeekDayItem.swift
//  SimpleWeather
//
//  Created by Alexander on 25.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

struct WeekDayItem {
    let name: String
    let weatherIconType: WeatherIconType
    var weatherIcon: UIImage {
        return UIImage(named: weatherIconType.rawValue) ?? UIImage(named: "test_icon")!
    }
    
    init(name: String, weatherIconType: WeatherIconType) {
        self.name = name
        self.weatherIconType = weatherIconType
    }
}
