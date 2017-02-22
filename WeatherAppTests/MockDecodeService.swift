//
//  MockDecodeService.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 20/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation

struct MockDecodeService: DecodeServiceProtocol {
    
    func decodeJSON(weatherData: NSData, forecastData: NSData, callback: CurrentWeatherModel -> Void) throws {
        
        var validforecast: [ForecastModel] = []
        validforecast.append(ForecastModel(forecastDay: 1466161200, forecastMinTemperature: 18, forecastMaxTemperature: 25))
        validforecast.append(ForecastModel(forecastDay: 1466247600, forecastMinTemperature: 14, forecastMaxTemperature: 21))
        validforecast.append(ForecastModel(forecastDay: 1466334000, forecastMinTemperature: 12, forecastMaxTemperature: 17))
        validforecast.append(ForecastModel(forecastDay: 1466420400, forecastMinTemperature: 13, forecastMaxTemperature: 18))
        validforecast.append(ForecastModel(forecastDay: 1466506800, forecastMinTemperature: 12, forecastMaxTemperature: 20))
        validforecast.append(ForecastModel(forecastDay: 1466593200, forecastMinTemperature: 14, forecastMaxTemperature: 24))
        validforecast.append(ForecastModel(forecastDay: 1466679600, forecastMinTemperature: 16, forecastMaxTemperature: 27))
        validforecast.append(ForecastModel(forecastDay: 1466766000, forecastMinTemperature: 20, forecastMaxTemperature: 29))
        
        let validWeatherModel = CurrentWeatherModel(cityName: "Lyon", currentWeather: "clear sky", currentTemperature: 19, detailsSunrise: 1466135419, detailsSunset: 1466191989, detailsClouds: 8, detailsRain: 0, detailsHumidity: 46, detailsPressure: 1012, forecastData: validforecast)
        callback(validWeatherModel)
    }
}