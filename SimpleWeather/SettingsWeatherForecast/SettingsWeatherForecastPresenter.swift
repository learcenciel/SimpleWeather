//
//  SettingsWeatherForecastPresenter.swift
//  SimpleWeather
//
//  Created by Alexander on 23.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import GooglePlaces

class SettingsWeatherForecastPresenter: NSObject, SettingsWeatherForecastPresenterProtocol {
    
    var view: SettingsWeatherForecastViewProtocol
    var interactor: SettingsWeatherForecastInteractorProtocol
    var router: SettingsWeatherForecastRouterProtocol!
    
    init(view: SettingsWeatherForecastViewProtocol,
         interactor: SettingsWeatherForecastInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func showAbout() {
        router.presentAbout(from: view)
    }
    
    func showCityChooser() {
        router.presentCityChooser(from: view)
    }
    
    func showCityPicker() {
        router.presentCityPicker(from: view)
    }
    
    func didSelectCurrentCity() {
        view.didSelectCurrentCity()
    }
    
    func didChooseCity(cityName: String, lattitude: Double, longtitude: Double) {
        interactor.selectCurrentCity(cityName: cityName, lattitude: lattitude, longtitude: longtitude)
    }
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        guard
            let cityName = place.name
            else { return }
        
        let lattitude = Double(place.coordinate.latitude)
        let longtitude = Double(place.coordinate.longitude)
        
        interactor.selectCurrentCity(cityName: cityName, lattitude: lattitude, longtitude: longtitude)
        (view as? UIViewController)?.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
        (view as? UIViewController)?.dismiss(animated: true, completion: nil)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        (view as? UIViewController)?.dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        //UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        //UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
