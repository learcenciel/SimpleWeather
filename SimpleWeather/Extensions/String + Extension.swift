//
//  String + Extension.swift
//  SimpleWeather
//
//  Created by Alexander on 25.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
