//
//  Array + Extension.swift
//  SimpleWeather
//
//  Created by Alexander on 23.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
