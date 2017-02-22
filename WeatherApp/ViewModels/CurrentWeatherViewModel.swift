//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 09/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// ViewModel to display Weather Data
struct CurrentWeatherViewModel: CurrentWeatherViewProtocol {
    
    var cityNameDisplay = Variable<String>("")
    var currentWeatherDisplay = Variable<String>("")
    var currentTemperatureDisplay = Variable<String>("")
    var detailsSunriseDisplay = Variable<String>("")
    var detailsSunsetDisplay = Variable<String>("")
    var detailsCloudsDisplay = Variable<String>("")
    var detailsRainDisplay = Variable<String>("")
    var detailsHumidityDisplay = Variable<String>("")
    var detailsPressureDisplay = Variable<String>("")
    
    var forecastDataDisplay = Variable<[ForecastViewModel]>([])

    let dateFormatter = NSDateFormatter()
    
    init(weatherService: WeatherServiceProtocol, decodeService: DecodeServiceProtocol) {
        
        
        dateFormatter.dateFormat = "hh:mm"
            
        weatherService.getWeatherJSON(Configuration.cityID, callback: { (weatherJSON, forecastJSON) in
            
            do {
                
                try decodeService.decodeJSON(weatherJSON, forecastData: forecastJSON, callback: { weatherInfos in
                    
                    self.cityNameDisplay.value = weatherInfos.cityName
                    self.currentWeatherDisplay.value = weatherInfos.currentWeather
                    self.currentTemperatureDisplay.value = "\(String(weatherInfos.currentTemperature))°"
                    self.detailsSunriseDisplay.value = "\(self.dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: weatherInfos.detailsSunrise))) AM"
                    self.detailsSunsetDisplay.value = "\(self.dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: weatherInfos.detailsSunset))) PM"
                    self.detailsCloudsDisplay.value = "\(String(weatherInfos.detailsClouds)) %"
                    self.detailsRainDisplay.value = "\(String(weatherInfos.detailsRain)) mm"
                    self.detailsHumidityDisplay.value = "\(String(weatherInfos.detailsHumidity)) %"
                    self.detailsPressureDisplay.value = "\(String(weatherInfos.detailsPressure)) hPa"
                    
                    for forecastData in weatherInfos.forecastData {
                        self.forecastDataDisplay.value.append(ForecastViewModel(forecastData: forecastData))
                    }
                })
            } catch {
                print("Error is: \(error)")
            }
            
            })
        }
}
