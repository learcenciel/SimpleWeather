//
//  WeeklyWeatherForecastPart.swift
//  SimpleWeather
//
//  Created by Alexander on 21.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import DITranquillity

class WeeklyWeatherForecastPart: DIPart {
    static func load(container: DIContainer) {
        
        container.register(WeeklyWeatherForecastViewController.self)
            .as(check: WeeklyWeatherForecastViewProtocol.self) {$0}
    }
}
