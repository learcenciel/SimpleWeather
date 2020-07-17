//
//  WeeklyWeatherForecastPresenter.swift
//  SimpleWeather
//
//  Created by Alexander on 25.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class WeeklyWeatherForecastPresenter: WeeklyWeatherForecastPresenterProtocol {
    var view: WeeklyWeatherForecastViewProtocol
    var interactor: WeeklyWeatherForecastInteractorProtocol
    
    init(view: WeeklyWeatherForecastViewProtocol,
         interactor: WeeklyWeatherForecastInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.retreiveWeeklyWeatherForecast()
    }
    
    func updateWeather() {
        interactor.retreiveWeeklyWeatherForecast()
    }
    
    func didRetreiveWeeklyWeatherForecast(_ weeklyWeatherForecast: [WeeklyHourlyWeatherForecast]) {
        view.showWeeklyWeatherForecast(weeklyWeatherForecast)
    }
}
