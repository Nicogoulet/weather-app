//
//  ForecastCellContentProtocol.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 14/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation

protocol ForecastCellContentProtocol {
    
    var forecastDay: String { get }
    var forecastMaxTemperature: String { get }
    var forecastMinTemperature: String { get }
    
}