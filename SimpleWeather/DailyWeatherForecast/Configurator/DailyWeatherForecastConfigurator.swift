//
//  DailyWeatherForecastConfigurator.swift
//  SimpleWeather
//
//  Created by Alexander on 26.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class DailyWeatherForecastConfigurator {
    
    class func createDailyWeatherForecastModule() -> UIViewController {
        
        let tabBarController =
            UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UITabBarController
        
        if let view = tabBarController.children.first as? DailyWeatherForecastViewController {
            let presenter = DailyForecastWeatherPresenter()
            let interactor = DailyWeatherForecastInteractor()
            
            view.presenter = presenter
            presenter.interactor = interactor
            presenter.view = view
            interactor.presenter = presenter
            interactor.httpClient = WeatherAPI.shared
            interactor.modelConverter = WeatherForecastConverter()
            
            return tabBarController
        }
        
        return UIViewController()
    }
}
