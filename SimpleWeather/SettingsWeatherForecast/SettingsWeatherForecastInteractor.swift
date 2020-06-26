//
//  SettingsWeatherForecastInteractor.swift
//  SimpleWeather
//
//  Created by Alexander on 23.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class SettingsWeatherForecastInteractor: SettingsWeatherForecastInteractorProtocol {
    private var currentUserSession: CurrentUserSession
    var presenter: SettingsWeatherForecastPresenterProtocol!
    
    init(currentUserSession: CurrentUserSession) {
        self.currentUserSession = currentUserSession
    }
    
    func selectCurrentCity(cityName: String,
                           lattitude: Double,
                           longtitude: Double) {
        currentUserSession.selectCurrentCity(cityName,
                                             lattitude,
                                             longtitude)
        presenter.didSelectCurrentCity()
    }
}
