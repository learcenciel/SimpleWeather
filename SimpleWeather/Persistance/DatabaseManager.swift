//
//  DatabaseManager.swift
//  SimpleWeather
//
//  Created by Alexander on 21.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import RealmSwift

class DatabaseManager {
    
    private let schemaVersion: UInt64 = 1
    
    // MARK: Configuration with migration support
    
    private lazy var realmConfiguration = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: runMigrations)
    private lazy var realm = try! Realm(configuration: realmConfiguration)
    
    // MARK: Migration block
    
    private func runMigrations(_ migration: Migration, oldSchemaVersion: UInt64) {
        
    }
    
    // MARK: Fetch, Delete, Add objects to Database
    
    func getCities() -> [WeatherCity] {
        return Array(realm.objects(WeatherCity.self))
    }
    
    func deleteCity(_ weatherCity: WeatherCity) {
        try! realm.write {
            realm.delete(weatherCity)
        }
    }
    
    func saveCity(_ weatherCityName: String,
                  lattitude: Float,
                  longtitude: Float,
                  isCurrent: Bool) {
        let weatherCity = WeatherCity(cityName: weatherCityName,
                                      lattitude: lattitude,
                                      longtitude: longtitude, isCurrent: isCurrent)
        try! realm.write {
            realm.add(weatherCity, update: .modified)
        }
    }
}
