//
//  WeatherForecastConverter.swift
//  SimpleWeather
//
//  Created by Alexander on 25.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class WeatherForecastConverter {
    
    var calendar: Calendar
    
    init() {
        calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0000)!
    }
    
    func weatherIconConverter(for icon: String, _ isCurrentWeather: Bool) -> WeatherIconType {
        switch icon {
        case "Clouds":
            return isCurrentWeather ? .mainClouds : .brokenClouds
        case "Clear":
            return .clearSky
        case "Snow":
            return .snow
        case "Rain":
            return .rain
        case "Drizzle":
            return .drizzle
        case "Thunderstorn":
            return .thunderStorm
        default: return .clearSky
        }
    }
    
    private func checkWeatherResponse(_ hourlyTemperatures: HourlyTemperatureList, _ calendar: Calendar) -> Bool {
        let date = NSDate(timeIntervalSince1970: TimeInterval(hourlyTemperatures.timeStamp))
        let currentDay = calendar.component(.day, from: Date())
        let responseDay = calendar.component(.day, from: date as Date)
        let responseHour = calendar.component(.hour, from: date as Date)
        return responseDay >= currentDay + 1 && responseDay <= currentDay + 3 &&
            (responseHour == 9 || responseHour == 15 || responseHour == 21)
    }
    
    func convertWeatherForecast(_ dailyWeatherResponse: DailyWeatherResponse, _ weeklyWeatherResponse: DailyHourlyWeatherResponse) -> WeatherForecast {
        
        let countryName = dailyWeatherResponse.systemInfo.countryName
        let cityName = dailyWeatherResponse.cityName
        let currentTemperature = String(format: "%.1f", dailyWeatherResponse.mainInfo.currentTemperature)
        let currentWeatherIcon = weatherIconConverter(for: dailyWeatherResponse.weatherDescription[0].weatherType, true)
        let currentAdditionalInfo = CurrentAdditionalInfo(wind: "\(String(dailyWeatherResponse.windInfo.windSpeed).replacingOccurrences(of: ".", with: ",")) m/h",
            windDeg: "\(String(format: "%0.f", dailyWeatherResponse.windInfo.windDeg)) deg",
                                                          humidity: "\(String(format: "%.0f", dailyWeatherResponse.mainInfo.currentHumidity))%",
            pressure: "\(String(format: "%1.f", dailyWeatherResponse.mainInfo.currentPressure).replacingOccurrences(of: ".", with: ",")) Pa")
        
        var futureDays: [TemperatureInfo] = []
        
        for hourlyTemperatures in weeklyWeatherResponse.hourlyTemperatureList where checkWeatherResponse(hourlyTemperatures, calendar) {
            let date = NSDate(timeIntervalSince1970: TimeInterval(hourlyTemperatures.timeStamp))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0000)!
            let formattedString = dateFormatter.string(from: date as Date)
            
            let iconType = weatherIconConverter(for: hourlyTemperatures.weatherInfo[0].weatherType, false)
            futureDays.append(TemperatureInfo(time: formattedString,
                                              weatherIconType: iconType,
                                              temperature: String(hourlyTemperatures.temperatureInfo.currentTemperature)))
        }
        
        return WeatherForecast(countryName: countryName,
                               cityName: cityName,
                               currentTemperature: currentTemperature, weatherIconType: currentWeatherIcon,
                               futureDays: futureDays,
                               currentAdditionalInfo: currentAdditionalInfo)
    }
}
