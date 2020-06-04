//
//  Int + Extension.swift
//  SimpleWeather
//
//  Created by Alexander on 04.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

extension Int {
    func getTime() -> String? {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0000)!
        let formattedString = dateFormatter.string(from: date as Date)
        
        return formattedString
    }
}
