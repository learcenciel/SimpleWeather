//
//  SettingsWeatherForecastProtocols.swift
//  SimpleWeather
//
//  Created by Alexander on 23.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import GooglePlaces
import UIKit

protocol SettingsWeatherForecastViewProtocol: class {
    var presenter: SettingsWeatherForecastPresenterProtocol! { get set }
    
    // PRESENTER -> VIEW
    func didSelectCurrentCity()
}

protocol SettingsWeatherForecastPresenterProtocol: GMSAutocompleteViewControllerDelegate, NSObject {
    var view: SettingsWeatherForecastViewProtocol { get set }
    var interactor: SettingsWeatherForecastInteractorProtocol { get set }
    var router: SettingsWeatherForecastRouterProtocol! { get set }
    
    // VIEW -> PRESENTER
    func showCityChooser()
    func showAbout()
    func showCityPicker()
    
    // INTERACTOR -> PRESENTER
    func didSelectCurrentCity()
}

protocol SettingsWeatherForecastRouterProtocol: class {
    // PRESENTER -> ROUTER
    func presentAbout(from view: SettingsWeatherForecastViewProtocol)
    func presentCityChooser(from view: SettingsWeatherForecastViewProtocol)
    func presentCityPicker(from view: SettingsWeatherForecastViewProtocol)
}

protocol SettingsWeatherForecastInteractorProtocol: class {
    var presenter: SettingsWeatherForecastPresenterProtocol! { get set }
    
    // PRESENTER -> INTERACTOR
    func selectCurrentCity(cityName: String, lattitude: Double, longtitude: Double)
}
