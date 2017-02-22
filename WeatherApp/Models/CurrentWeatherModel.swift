//
//  WeatherAPICaller.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 12/05/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation

// Struct storing the weather infos after they've been retrieved from API
struct CurrentWeatherModel {
    
    var cityName: String
    var currentWeather: String
    var currentTemperature: Int
    var detailsSunrise: Double
    var detailsSunset: Double
    var detailsClouds: Int
    var detailsRain: Int
    var detailsHumidity: Int
    var detailsPressure: Int
    var forecastData: [ForecastModel]
    
}