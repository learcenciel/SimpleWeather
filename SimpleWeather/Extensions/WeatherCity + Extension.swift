//
//  WeatherCity + Extension.swift
//  SimpleWeather
//
//  Created by Alexander on 24.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import CoreLocation

extension RealmCity {
    var location: CLLocation {
        return CLLocation(latitude: self.lattitude,
                          longitude: self.longtitude)
    }
}
