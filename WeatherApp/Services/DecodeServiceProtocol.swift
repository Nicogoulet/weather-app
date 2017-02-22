//
//  DecodeServiceProtocol.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 17/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation

protocol DecodeServiceProtocol {
    
    /** Decode JSON files received from API then callback with filled WeatherInfoModel
     
     - Parameters:
     - weatherData: NSData containing current weather infos
     - forecastData: NSData containing forecast infos
     - callback: callback function called once data is retrieved with a CurrentWeatherModel as parameter
     */
    func decodeJSON(weatherData: NSData, forecastData: NSData, callback: CurrentWeatherModel -> Void) throws
    
}