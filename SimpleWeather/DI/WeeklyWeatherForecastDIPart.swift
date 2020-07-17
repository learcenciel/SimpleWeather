//
//  WeeklyWeatherForecastPart.swift
//  SimpleWeather
//
//  Created by Alexander on 21.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity
import Foundation

class WeeklyWeatherForecastDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(WeeklyWeatherForecastViewController.self)
            .as(check: WeeklyWeatherForecastViewProtocol.self) {$0}
            .injection(cycle: true, \.presenter)
            .lifetime(.objectGraph)
        
        container.register(WeeklyWeatherForecastPresenter.init)
            .as(check: WeeklyWeatherForecastPresenterProtocol.self) {$0}
            .lifetime(.objectGraph)
        
        container.register(WeeklyWeatherForecastInteractor.init)
            .as(check: WeeklyWeatherForecastInteractorProtocol.self) {$0}
            .injection(cycle: true, \.presenter)
            .lifetime(.objectGraph)
        
        container.register(WeeklyWeatherForecastConverter.init)
            .lifetime(.objectGraph)
    }
}
