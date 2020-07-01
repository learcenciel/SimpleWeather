//
//  SelectCityWeatherForecastDIPart.swift
//  SimpleWeather
//
//  Created by Alexander on 29.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity
import Foundation

class SelectCityWeatherForecastDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(UINavigationController.self)
            .lifetime(.objectGraph)
        
        container.register(SelectCityWeatherForecastViewController.self)
            .as(check: SelectCityWeatherForecastViewProtocol.self) {$0}
            .injection(cycle: true, \.presenter)
            .lifetime(.objectGraph)
        
        container.register(SelectCityWeatherForecastPresenter.init)
            .as(check: SelectCityWeatherForecastPresenterProtocol.self) {$0}
            .lifetime(.objectGraph)
        
        container.register(SelectCityWeatherForecastInteractor.init)
            .as(check: SelectCityWeatherForecastInteractorProtocol.self) {$0}
            .injection(cycle: true, \.presenter)
            .lifetime(.objectGraph)
    }
}
