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
}

protocol DailyWeatherForecastConfiguratorProtocol: class {
    static func createDailyWeatherForecastModule() -> UIViewController
}

protocol DailyWeatherForecastRouterProtocol: class {
    func showWeeklyChart(from view: DailyWeatherForecastViewProtocol, forCity cityId: Int)
}

protocol DailyWeatherForecastPresenterProtocol: class {
    var view: DailyWeatherForecastViewProtocol { get set }
    var interactor: DailyWeatherForecastInteractorProtocol! { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func updateWeather()
    
    // INTERACTOR -> PRESENTER
    func didRetreiveWeatherForecast(_ weatherForecast: WeatherForecast)
}

protocol DailyWeatherForecastInteractorProtocol: class, CLLocationManagerDelegate {
    var presenter: DailyWeatherForecastPresenterProtocol! { get set }
    var httpClient: WeatherAPI { get set }
    var modelConverter: WeatherForecastConverter { get set }
    var locationManager: CoreLocationManager! { get set }
    
    // PRESENTER -> INTERACTOR
    func retreiveDailyWeatherForecast()
    
    // HTTPCLIENT -> INTERACTOR
    func didRetreieveWeatherForecastFromNetwork(_ weatherForecast: WeatherForecast?)
}
