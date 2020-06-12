//
//  UITabViewControllerPart.swift
//  SimpleWeather
//
//  Created by Alexander on 06.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity

class UITabViewControllerPart: DIPart {
    static func load(container: DIContainer) {
        container.register(UITabBarController.self)
            .lifetime(.single)
    }
}
