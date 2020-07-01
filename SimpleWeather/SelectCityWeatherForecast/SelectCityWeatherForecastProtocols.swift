//
//  SelectCityWeatherForecastProtocols.swift
//  SimpleWeather
//
//  Created by Alexander on 28.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

protocol SelectCityWeatherForecastViewProtocol: class {
    var presenter: SelectCityWeatherForecastPresenterProtocol! { get set }
    
    // PRESENTER -> VIEW
    func didRetreieveCitiesFromDatabase(_ cities: [RealmCity])
    func didSelectCurrentCity()
}

protocol SelectCityWeatherForecastPresenterProtocol: class {
    var view: SelectCityWeatherForecastViewProtocol { get set }
    var interactor: SelectCityWeatherForecastInteractorProtocol { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func selectCurrent(_ realmCity: RealmCity)
    func delete(_ cities: [RealmCity])
    
    // INTERACTOR -> PRESENTER
    func didRetreieveCitiesFromDatabase(_ cities: [RealmCity])
    func didSelectCurrentCity()
}

protocol SelectCityWeatherForecastInteractorProtocol: class {
    var presenter: SelectCityWeatherForecastPresenterProtocol! { get set }
    
    // PRESENTER -> INTERACTOR
    func retreiveCitiesFromDatabase()
    func selectCurrentCity(_ realmCity: RealmCity)
    func delete(_ cities: [RealmCity])
}
