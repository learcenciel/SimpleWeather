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
    
    func getCities() -> [RealmCity] {
        return Array(realm.objects(RealmCity.self))
    }
    
    func delete(city: RealmCity) {
        try! realm.write {
            realm.delete(realm.objects(RealmCity.self).filter("name=%@", city.name))
        }
    }
    
    func saveCity(_ name: String,
                  lattitude: Double,
                  longtitude: Double,
                  isCurrent: Bool) {
        let weatherCity = RealmCity(cityName: name,
                                      lattitude: lattitude,
                                      longtitude: longtitude, isCurrent: isCurrent)
        try! realm.write {
            realm.create(RealmCity.self, value: weatherCity, update: .all)
        }
    }
}
