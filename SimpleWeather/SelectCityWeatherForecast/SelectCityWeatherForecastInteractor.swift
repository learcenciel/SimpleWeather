//
//  SelectCityWeatherForecastInteractor.swift
//  SimpleWeather
//
//  Created by Alexander on 29.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class SelectCityWeatherForecastInteractor: SelectCityWeatherForecastInteractorProtocol {
    var presenter: SelectCityWeatherForecastPresenterProtocol!
    var databaseManager: DatabaseManager
    var currentUserSession: CurrentUserSession
    
    init(databaseManager: DatabaseManager,
         currentUserSession: CurrentUserSession) {
        self.databaseManager = databaseManager
        self.currentUserSession = currentUserSession
    }
    
    func delete(_ cities: [RealmCity]) {
        cities.forEach { databaseManager.delete(city: $0) }
    }
    
    func retreiveCitiesFromDatabase() {
        presenter.didRetreieveCitiesFromDatabase(databaseManager.getCities())
    }
    
    func selectCurrentCity(_ realmCity: RealmCity) {
        currentUserSession.selectCurrentCity(realmCity.name,
                                             realmCity.lattitude,
                                             realmCity.longtitude)
        presenter.didSelectCurrentCity()
    }
}
