//
//  WeatherCity.swift
//  SimpleWeather
//
//  Created by Alexander on 21.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherCity: Object {
    
    @objc dynamic var cityName: String
    @objc dynamic var lattitude: Double
    @objc dynamic var longtitude: Double
    @objc dynamic var isCurrent: Bool
    
    init(cityName: String,
         lattitude: Double,
         longtitude: Double,
         isCurrent: Bool) {
        self.cityName = cityName
        self.lattitude = lattitude
        self.longtitude = longtitude
        self.isCurrent = isCurrent
    }
    
    required init() {
        self.cityName = ""
        self.lattitude = 0.0
        self.longtitude = 0.0
        self.isCurrent = false
    }
    
    override class func primaryKey() -> String? {
        return "cityName"
    }
}
