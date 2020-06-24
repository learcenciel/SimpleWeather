//
//  Float + Extension.swift
//  SimpleWeather
//
//  Created by Alexander on 04.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

extension WeatherForecast {
    
    func getTemperature() -> String? {
        return String(format: "%.1f", self.currentTemperature).replacingOccurrences(of: ".", with: ",") + "°"
    }
    
    func getWindSpeed() -> String? {
        return String(format: "%.1f", self.currentAdditionalInfo.wind).replacingOccurrences(of: ".", with: ",") + " m/h"
    }
    
    func getHumidity() -> String? {
        return String(format: "%.0f", self.currentAdditionalInfo.humidity).replacingOccurrences(of: ".", with: ",") + " %"
    }
    
    func getPressure() -> String? {
        return String(format: "%.0f", self.currentAdditionalInfo.pressure) + " PA"
    }
    
    func getWindDegree() -> String? {
        return String(format: "%.0f", self.currentAdditionalInfo.windDeg).replacingOccurrences(of: ".", with: ",") + " deg"
    }
}
