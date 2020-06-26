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
    
    private func checkWeatherResponse(_ hourlyTemperatures: HourlyTemperatureList,
                                      _ calendar: Calendar) -> Bool {
        let date = NSDate(timeIntervalSince1970: TimeInterval(hourlyTemperatures.timeStamp))
        let currentDay = calendar.component(.day, from: Date())
        let responseDay = calendar.component(.day, from: date as Date)
        let responseHour = calendar.component(.hour, from: date as Date)
        return responseDay >= currentDay + 1 && responseDay <= currentDay + 3 &&
            (responseHour == 9 || responseHour == 15 || responseHour == 21)
    }
    
    func convertWeatherForecast(_ dailyWeatherResponse: DailyWeatherResponse,
                                _ weeklyWeatherResponse: DailyHourlyWeatherResponse) -> WeatherForecast {
        
        let countryName = dailyWeatherResponse.systemInfo.countryName
        let cityName = dailyWeatherResponse.cityName
        let currentTemperature = dailyWeatherResponse.mainInfo.currentTemperature
        let currentWeatherIcon = weatherIconConverter(for: dailyWeatherResponse.weatherDescription[0].weatherType, true)
        let currentAdditionalInfo =
            CurrentAdditionalInfo(windSpeed: dailyWeatherResponse.windInfo.windSpeed,
                                  windDegree: dailyWeatherResponse.windInfo.windDeg,
                                  humidity: dailyWeatherResponse.mainInfo.currentHumidity,
                                  pressure: dailyWeatherResponse.mainInfo.currentPressure)
        
        var futureDays: [TemperatureInfo] = []
        
        for hourlyTemperatures in weeklyWeatherResponse.hourlyTemperatureList where checkWeatherResponse(hourlyTemperatures, calendar) {
            let iconType = weatherIconConverter(for: hourlyTemperatures.weatherInfo[0].weatherType, false)
            futureDays.append(TemperatureInfo(time: hourlyTemperatures.timeStamp,
                                              weatherIconType: iconType,
                                              temperature: hourlyTemperatures.temperatureInfo.currentTemperature))
        }
        
        return WeatherForecast(countryName: countryName,
                               cityName: cityName,
                               timeZone: dailyWeatherResponse.timeZone,
                               currentTemperature: currentTemperature, weatherIconType: currentWeatherIcon,
                               futureDays: futureDays,
                               currentAdditionalInfo: currentAdditionalInfo,
                               sunrise: dailyWeatherResponse.systemInfo.sunrise,
                               sunset: dailyWeatherResponse.systemInfo.sunset)
    }
}
