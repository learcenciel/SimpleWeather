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
}

protocol WeeklyWeatherForecastPresenterProtocol: class {
    var view: WeeklyWeatherForecastViewProtocol { get set }
    var interactor: WeeklyWeatherForecastInteractorProtocol! { get set }
}

protocol WeeklyWeatherForecastInteractorProtocol: class, CLLocationManagerDelegate {
    var presenter: WeeklyWeatherForecastPresenterProtocol! { get set }
}
