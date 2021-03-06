//
//  Date + Extension.swift
//  SimpleWeather
//
//  Created by Alexander on 24.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

extension Date {
    func checkIfDateInRange(start: Date, end: Date) -> Bool {
        return self >= start && self <= end
    }
}
