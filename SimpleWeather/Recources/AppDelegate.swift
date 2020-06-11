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
        
        let container = DIContainer()
        container.append(framework: AppFramework.self)
        
        if container.validate(checkGraphCycles: true) == false {
            fatalError()
        }
        
        container.initializeSingletonObjects()
        
        let storyboard: UIStoryboard = container.resolve(name: "Main")
        
        let vc = storyboard.instantiateInitialViewController() as! UITabBarController
        
//        vc.tabBar.tintColor = .darkGray
//        vc.tabBar.unselectedItemTintColor = .lightGray
//        vc.tabBar.color
//        vc.tabBar.tintAdjustmentMode = .automatic
//        vc.tabBar.barTintColor = .white
//        vc.tabBar.layer.borderWidth = 0
//        vc.tabBar.layer.borderColor = UIColor.clear.cgColor
//        vc.tabBar.clipsToBounds = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }

}

