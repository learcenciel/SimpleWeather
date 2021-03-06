//
//  DailyWeatherForecastProtocols.swift
//  SimpleWeather
//
//  Created by Alexander on 26.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import CoreLocation
import UIKit

protocol DailyWeatherForecastViewProtocol: class {
    var presenter: DailyWeatherForecastPresenterProtocol! { get set }
    
    // PRESENTER -> VIEW
    func showCurrentWeather(with currentWeather: WeatherForecast)
    func showLocationError(_ error: String)
}

protocol DailyWeatherForecastPresenterProtocol: class {
    var view: DailyWeatherForecastViewProtocol { get set }
    var interactor: DailyWeatherForecastInteractorProtocol { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func updateWeather()
    
    // INTERACTOR -> PRESENTER
    func didRetreiveWeatherForecast(_ weatherForecast: WeatherForecast)
    func didRetrieveLocationError(_ error: CLError)
    func didRetreieveLocationAccessDenied(_ error: String)
}

protocol DailyWeatherForecastInteractorProtocol: class, CLLocationManagerDelegate {
    var presenter: DailyWeatherForecastPresenterProtocol! { get set }
    
    // PRESENTER -> INTERACTOR
    func retreiveDailyWeatherForecast()
}
