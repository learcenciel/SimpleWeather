//
//  CoreLocationManager.swift
//  SimpleWeather
//
//  Created by Alexander on 05.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import CoreLocation

class CoreLocationManager {
    
    private let locationManager = CLLocationManager()
    var delegate: CLLocationManagerDelegate
    
    init(delegate: CLLocationManagerDelegate) {
        self.delegate = delegate
        checkLocationServices()
    }
    
    func setupLocationManager() {
        locationManager.delegate = delegate
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            print("Cannot setup Location Manager: Location Services are not enabled")
        }
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            print("Authorization granted!")
            break
        case .denied:
            print("Authorization is denied!")
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Authorization restricted: Unknown status")
            break
        case .authorizedAlways:
            break
        default:
            print("Authorization cannot be requested: Unknown status")
        }
    }
    
    func requestCurrentLocation() {
        
        guard CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse else { return }
        
        locationManager.requestLocation()
    }
}
