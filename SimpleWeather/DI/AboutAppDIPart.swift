//
//  AboutAppDIPart.swift
//  SimpleWeather
//
//  Created by Alexander on 01.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity
import Foundation

class AboutAppDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(AboutAppViewController.self)
            .lifetime(.objectGraph)
    }
}
