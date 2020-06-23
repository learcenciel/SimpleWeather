//
//  SettingsWeatherForecastPart.swift
//  SimpleWeather
//
//  Created by Alexander on 23.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import GooglePlaces
import DITranquillity

class SettingsWeatherForecastPart: DIPart {
    static func load(container: DIContainer) {
        
        container.register(SettingsWeatherForecastViewController.self)
            .as(check: SettingsWeatherForecastViewProtocol.self) {$0}
            .injection(cycle: true, \.presenter)
            .lifetime(.objectGraph)
        
        container.register(SettingsWeatherForecastPresenter.init)
            .as(check: SettingsWeatherForecastPresenterProtocol.self) {$0}
            .as(GMSAutocompleteViewControllerDelegate.self)
            .injection(cycle: true, \.router)
            .lifetime(.objectGraph)
        
        container.register(SettingsWeatherForecastInteractor.init)
            .as(check: SettingsWeatherForecastInteractorProtocol.self) {$0}
            .injection(cycle: true, \.presenter)
            .lifetime(.objectGraph)
        
        container.register(SettingsWeatherForecastRouter.init)
            .as(check: SettingsWeatherForecastRouterProtocol.self) {$0}
            .lifetime(.objectGraph)
    }
}
