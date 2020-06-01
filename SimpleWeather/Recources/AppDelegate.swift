//
//  AppDelegate.swift
//  SimpleWeather
//
//  Created by Alexander on 25.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let dailyWeatherForecastViewController = DailyWeatherForecastConfigurator.createDailyWeatherForecastModule()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = dailyWeatherForecastViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

