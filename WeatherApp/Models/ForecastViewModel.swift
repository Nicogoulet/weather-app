//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 13/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation

// View Model to display Forecast Data in table view cells
struct ForecastViewModel: ForecastCellContentProtocol {
    
    var forecastDay: String
    var forecastMaxTemperature: String
    var forecastMinTemperature: String
    
    let dateFormatter = NSDateFormatter()
    
    init(forecastData: ForecastModel) {
        
        dateFormatter.dateFormat = "EEEE"

        self.forecastDay = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: forecastData.forecastDay))
        self.forecastMaxTemperature = String(forecastData.forecastMaxTemperature)
        self.forecastMinTemperature = String(forecastData.forecastMinTemperature)
        
    }
}