//
//  DailyForecastWeatherPresenter.swift
//  SimpleWeather
//
//  Created by Alexander on 26.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class DailyForecastWeatherPresenter: DailyWeatherForecastPresenterProtocol {
    
    var view: DailyWeatherForecastViewProtocol
    var interactor: DailyWeatherForecastInteractorProtocol!
    
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
    
    func didRetrieveLocationError(_ error: String) {
        view.showLocationError(error)
    }
}
