//
//  WeeklyWeatherForecastConverter.swift
//  SimpleWeather
//
//  Created by Alexander on 25.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import UIKit

class WeeklyWeatherForecastConverter {
    
    private var calendar: Calendar
    private var dateFormatter = DateFormatter()
    
    init() {
        calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0000)!
    }
    
    func weatherIconConverter(for icon: String, _ isCurrentWeather: Bool) -> WeatherIconType {
        switch icon {
        case "Clouds":
            return isCurrentWeather ? .mainClouds : .clouds
        case "Clear":
            return isCurrentWeather ? .mainClear : .clear
        case "Atmosphere":
            return isCurrentWeather ? .mainAtmosphere : .atmosphere
        case "Snow":
            return isCurrentWeather ? .mainSnow : .snow
        case "Rain":
            return isCurrentWeather ? .mainRain : .rain
        case "Drizzle":
            return isCurrentWeather ? .mainDrizzle : .drizzle
        case "Thunderstorn":
            return isCurrentWeather ? .mainThunderstorm : .thunderStorm
        default:
            return isCurrentWeather ? .mainClear : .clear
        }
    }
    
    private func checkWeatherResponse(_ hourlyTemperatures: HourlyTemperatureInfo,
                                      _ calendar: Calendar) -> Bool {
        let responseDate = NSDate(timeIntervalSince1970: TimeInterval(hourlyTemperatures.timeStamp))
        let responseHour = calendar.component(.hour, from: responseDate as Date)
        
        let beginingCurrentDay = calendar.startOfDay(for: Date())
        
        if (responseDate as Date) >= calendar.date(byAdding: .day, value: 1, to: beginingCurrentDay)! && (responseDate as Date) <= calendar.date(byAdding: .day, value: 5, to: beginingCurrentDay)! {
            if (responseHour == 9 || responseHour == 15 || responseHour == 21) {
                return true
            }
        }
        return false
    }
    
    func convertWeeklyWeatherForecast(_ weeklyHourlyWeatherResponse: WeeklyHourlyWeatherResponse) -> [WeeklyHourlyWeatherForecast] {
        
        var weekDaysWeatherForecast: [WeeklyHourlyWeatherForecast] = []
        var currentDayHourlyTemperatureInfo: [CurrentDayHourlyTemperatureInfo] = []
        
        for hourlyTemperatures in weeklyHourlyWeatherResponse.hourlyTemperatureList where checkWeatherResponse(hourlyTemperatures, calendar) {
            currentDayHourlyTemperatureInfo.append(CurrentDayHourlyTemperatureInfo(hourTime: Date(timeIntervalSince1970: TimeInterval(hourlyTemperatures.timeStamp)), temperature: hourlyTemperatures.temperatureInfo.currentTemperature, temperatureDescription: hourlyTemperatures.weatherInfo[0].weatherDescription))
        }
        
        for (index, chunked) in currentDayHourlyTemperatureInfo.chunked(into: 3).enumerated() {
            dateFormatter.dateFormat = "EEEE"
            let weekDayName = dateFormatter.string(from: chunked[0].hourTime)
            let currentDayTemperature = weeklyHourlyWeatherResponse.hourlyTemperatureList[index].temperatureInfo.currentTemperature
            let currentWeatherIconType = weatherIconConverter(for: weeklyHourlyWeatherResponse.hourlyTemperatureList[index].weatherInfo[0].weatherType, true)
            let currentDayAdditionalInfo = CurrentAdditionalInfo(windSpeed: weeklyHourlyWeatherResponse.hourlyTemperatureList[index].windInfo.windSpeed, windDegree: weeklyHourlyWeatherResponse.hourlyTemperatureList[index].windInfo.windDeg, humidity: weeklyHourlyWeatherResponse.hourlyTemperatureList[index].temperatureInfo.currentHumidity, pressure: weeklyHourlyWeatherResponse.hourlyTemperatureList[index].temperatureInfo.currentPressure)
            dateFormatter.dateFormat = "EEEEE"
            let weekShortDayName = dateFormatter.string(from: chunked[0].hourTime)
            let weekDayItem = WeekDayItem(name: weekShortDayName, weatherIconType: weatherIconConverter(for: weeklyHourlyWeatherResponse.hourlyTemperatureList[index].weatherInfo[0].weatherType, false))
            weekDaysWeatherForecast.append(WeeklyHourlyWeatherForecast(weekDayName: weekDayName, currentDayTemperature: currentDayTemperature, weatherIconType: currentWeatherIconType, currentDayAdditionalInfo: currentDayAdditionalInfo, currentDayHourlyInfo: chunked, weekDayItem: weekDayItem))
        }
        
        return weekDaysWeatherForecast
    }
}
