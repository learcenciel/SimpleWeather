//
//  CurrentUserSession.swift
//  SimpleWeather
//
//  Created by Alexander on 21.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class CurrentUserSession {
    
    var databaseManager: DatabaseManager!
    
    func getCurrentCity() -> WeatherCity? {
        return databaseManager.getCities().first {
            return $0.isCurrent
        }
    }
    
    func selectCurrentCity(_ currentCityName: String,
                           lattitude: Double,
                           longtitude: Double) {
        databaseManager.getCities().forEach { weatherCity in
            databaseManager.saveCity(weatherCity.cityName,
                                     lattitude: weatherCity.lattitude,
                                     longtitude: weatherCity.longtitude,
                                     isCurrent: false)
            
            databaseManager.saveCity(currentCityName, lattitude: lattitude, longtitude: longtitude, isCurrent: true)
        }
    }
}
