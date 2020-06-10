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
        container.append(part: DailyWeatherForecastPart.self)
        container.append(part: NetworkingPart.self)
        container.append(part: UITabViewControllerPart.self)
    }
}
