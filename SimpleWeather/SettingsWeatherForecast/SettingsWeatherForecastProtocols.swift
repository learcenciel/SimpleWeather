//
//  SettingsWeatherForecastProtocols.swift
//  SimpleWeather
//
//  Created by Alexander on 23.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity
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
    
    // INTERACTOR -> PRESENTER
    func didSelectCurrentCity()
    
    // CityPicker Delegate -> PRESENTER
    func didChooseCity(cityName: String, lattitude: Double, longtitude: Double)
}

protocol SettingsWeatherForecastRouterProtocol: class {
    
    var container: DIContainer { get set }
    
    // PRESENTER -> ROUTER
    func presentCityChooser(from view: SettingsWeatherForecastViewProtocol)
}

protocol SettingsWeatherForecastInteractorProtocol: class {
    
    var currentUserSession: CurrentUserSession { get set }
    var presenter: SettingsWeatherForecastPresenterProtocol! { get set }
    
    // PRESENTER -> INTERACTOR
    func selectCurrentCity(cityName: String, lattitude: Double, longtitude: Double)
}
