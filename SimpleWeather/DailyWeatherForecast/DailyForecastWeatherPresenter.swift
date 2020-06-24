//
//  DailyForecastWeatherPresenter.swift
//  SimpleWeather
//
//  Created by Alexander on 26.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import CoreLocation
import Foundation

class DailyForecastWeatherPresenter: DailyWeatherForecastPresenterProtocol {
    
    var view: DailyWeatherForecastViewProtocol
    var interactor: DailyWeatherForecastInteractorProtocol
    
    init(view: DailyWeatherForecastViewProtocol,
         interactor: DailyWeatherForecastInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.retreiveDailyWeatherForecast()
    }
    
    func updateWeather() {
        interactor.retreiveDailyWeatherForecast()
    }
    
    func didRetreiveWeatherForecast(_ weatherForecast: WeatherForecast) {
        view.showCurrentWeather(with: weatherForecast)
    }
    
    func didRetreieveLocationAccessDenied(_ error: String) {
        view.showLocationError("Please give an location access in settings")
    }
    
    func didRetrieveLocationError(_ error: CLError) {
        switch error {
        case CLError.locationUnknown:
            view.showLocationError("Location Unknown")
        case CLError.denied:
            view.showLocationError("Location access denied")
        default:
            view.showLocationError("Unknown error")
        }
    }
}
