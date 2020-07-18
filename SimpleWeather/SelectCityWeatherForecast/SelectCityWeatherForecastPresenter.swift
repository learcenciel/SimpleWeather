//
//  SelectCityWeatherForecastPresenter.swift
//  SimpleWeather
//
//  Created by Alexander on 29.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class SelectCityWeatherForecastPresenter: SelectCityWeatherForecastPresenterProtocol {
    var view: SelectCityWeatherForecastViewProtocol
    var interactor: SelectCityWeatherForecastInteractorProtocol
    
    init(view: SelectCityWeatherForecastViewProtocol,
         interactor: SelectCityWeatherForecastInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.retreiveCitiesFromDatabase()
    }
    
    func selectCurrent(_ realmCity: RealmCity) {
        interactor.selectCurrentCity(realmCity)
    }
    
    func delete(_ cities: [RealmCity]) {
        interactor.delete(cities)
    }
    
    func didRetreieveCitiesFromDatabase(_ cities: [RealmCity]) {
        view.didRetreieveCitiesFromDatabase(cities)
    }
    
    func didSelectCurrentCity() {
        view.didSelectCurrentCity()
    }
}
