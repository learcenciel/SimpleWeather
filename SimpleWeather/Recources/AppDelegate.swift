//
//  AppDelegate.swift
//  SimpleWeather
//
//  Created by Alexander on 25.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //let dailyWeatherForecastViewController = DailyWeatherForecastConfigurator.createDailyWeatherForecastModule()
        
        let container = DIContainer()
        container.append(framework: AppFramework.self)
        
        if container.validate(checkGraphCycles: true) == false {
            fatalError()
        }
        
        container.initializeSingletonObjects()
        
        let storyboard: UIStoryboard = container.resolve(name: "Main")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = storyboard.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

