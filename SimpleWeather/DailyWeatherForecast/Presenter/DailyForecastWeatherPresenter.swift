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
    //var router: DailyWeatherForecastRouterProtocol?
    
    init(view: DailyWeatherForecastViewProtocol,
         interactor: DailyWeatherForecastInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func viewDidLoad(lat: Float, lon: Float) {
        interactor.retreiveDailyWeatherForecast(lat: lat, lon: lon)
    }
    
    func updateWeather(lat: Float, lon: Float) {
        interactor.retreiveDailyWeatherForecast(lat: lat, lon: lon)
    }
    
    func didRetreiveWeatherForecast(_ weatherForecast: WeatherForecast) {
        view.showCurrentWeather(with: weatherForecast)
    }
}
