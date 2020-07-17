//
//  DailyWeatherForecastPart.swift
//  SimpleWeather
//
//  Created by Alexander on 04.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import CoreLocation
import DITranquillity

class DailyWeatherForecastDIPart: DIPart {
    static func load(container: DIContainer) {
        container.registerStoryboard(name: "Main")
            .lifetime(.single)
        
        container.register(DailyWeatherForecastViewController.self)
            .as(check: DailyWeatherForecastViewProtocol.self) {$0}
            .injection(cycle: true, \.presenter)
            .lifetime(.objectGraph)
        
        container.register(DailyForecastWeatherPresenter.init)
            .as(check: DailyWeatherForecastPresenterProtocol.self) {$0}
            .lifetime(.objectGraph)
        
        container.register(DailyWeatherForecastInteractor.init)
            .as(check: DailyWeatherForecastInteractorProtocol.self) {$0}
            .as(CLLocationManagerDelegate.self)
            .injection(cycle: true, \.presenter)
            .injection(cycle: true, \.locationManager)
            .lifetime(.objectGraph)
        
        container.register(CoreLocationManager.init)
            .lifetime(.objectGraph)
    }
}
