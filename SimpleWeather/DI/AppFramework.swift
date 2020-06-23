//
//  AppFramework.swift
//  SimpleWeather
//
//  Created by Alexander on 04.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity

public class AppFramework: DIFramework {
    public static func load(container: DIContainer) {
        container.append(part: DailyWeatherForecastDIPart.self)
        container.append(part: WeeklyWeatherForecastDIPart.self)
        container.append(part: NetworkingDIPart.self)
        container.append(part: UITabViewControllerDIPart.self)
        container.append(part: PersistanceDIPart.self)
        container.append(part: SettingsWeatherForecastDIPart.self)
    }
}
