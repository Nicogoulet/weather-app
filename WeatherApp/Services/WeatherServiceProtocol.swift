//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 14/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation

/// Handles calls to the OpenWeatherMap API
protocol WeatherServiceProtocol {
 
    /** Get the current Weather and Forecast Infos using the cityID and returning NSData
     
     - Parameters:
        - cityID: ID of the city
        - callback: callback function called once data is retrieved with both currentweather and forecast infos as NSData as parameter
    */
    func getWeatherJSON(cityID: String, callback: (NSData, NSData) -> Void)

}