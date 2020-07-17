//
//  NetworkingPart.swift
//  SimpleWeather
//
//  Created by Alexander on 04.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity

class NetworkingDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(WeatherForecastConverter.init)
        container.register(WeatherAPI.init)
            .lifetime(.single)
        container.register(HTTPClient.init)
    }
}
