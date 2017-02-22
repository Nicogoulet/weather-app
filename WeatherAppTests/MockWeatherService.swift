//
//  MockWeatherService.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 20/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation

struct MockWeatherService: WeatherServiceProtocol {
    
    var validWeather: Bool
    var validForecast: Bool
    
    var bundle: NSBundle
    
    func getWeatherJSON(cityID: String, callback: (NSData, NSData) -> Void) {
        
        var weatherData = NSData()
        var forecastData = NSData()
        
        if validWeather {
            if let weatherDataPath = bundle.pathForResource("ValidWeatherData", ofType: "json")
            {
                weatherData = NSData(contentsOfFile: weatherDataPath)!
            }
        } else {
            if let weatherDataPath = bundle.pathForResource("NotValidWeatherData", ofType: "json")
            {
                weatherData = NSData(contentsOfFile: weatherDataPath)!
            }
        }
        
        if validForecast {
            if let forecastDataPath = bundle.pathForResource("ValidForecastData", ofType: "json")
            {
                forecastData = NSData(contentsOfFile: forecastDataPath)!
            }
            
        } else {
            if let forecastDataPath = bundle.pathForResource("NotValidForecastData", ofType: "json")
            {
                forecastData = NSData(contentsOfFile: forecastDataPath)!
            }
        }
        
        callback(weatherData, forecastData)
    }
}