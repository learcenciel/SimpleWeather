//
//  WeeklyWeatherForecastProtocols.swift
//  SimpleWeather
//
//  Created by Alexander on 21.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import CoreLocation
import UIKit

protocol WeeklyWeatherForecastViewProtocol: class {
    var presenter: WeeklyWeatherForecastPresenterProtocol! { get set }
    
    // PRESENTER -> VIEW
    func showWeeklyWeatherForecast(_ weeklyWeatherForecast: [WeeklyHourlyWeatherForecast])
}

protocol WeeklyWeatherForecastPresenterProtocol: class {
    var view: WeeklyWeatherForecastViewProtocol { get set }
    var interactor: WeeklyWeatherForecastInteractorProtocol { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func updateWeather()
    
    // INTERACTOR -> PRESENTER
    func didRetreiveWeeklyWeatherForecast(_ weeklyWeatherForecast: [WeeklyHourlyWeatherForecast])
}

protocol WeeklyWeatherForecastInteractorProtocol: class {
    var presenter: WeeklyWeatherForecastPresenterProtocol! { get set }
    
    // PRESENTER -> INTERACTOR
    func retreiveWeeklyWeatherForecast()
}
