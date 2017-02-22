//
//  APICallerModel.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 13/05/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherService: WeatherServiceProtocol {
    
// Used in getWeatherInfos. Get current weather infos in NSData format using Alamofire Request then call callback function
    private func getCurrentWeatherInfos(cityID: String, callback: NSData -> Void) {
    
        Alamofire.request(.GET, Configuration.WebService.urlRoot + Configuration.WebService.weatherURL, parameters: ["id": cityID , "appid": Configuration.Api.authKey , "units": "metric"]).validate().response { request, response, data, error in
            
            guard error == nil else {
                print("Error while fetching infos: \(error)")
                return
            }

            callback(data!)
        }
    }
    
// Used in getWeatherInfos. Get forecast for the next 8 days in NSData format using Alamofire Request then call callback function
    private func getForecastWeatherInfos(cityID: String, callback: NSData -> Void) {
 
        Alamofire.request(.GET, Configuration.WebService.urlRoot + Configuration.WebService.forecastURL , parameters: ["id": cityID , "mode": "JSON", "units": "metric", "cnt": "8", "appid":Configuration.Api.authKey]).validate().response { request, response, data, error in
            
            guard error == nil else {
                print("Error while fetching infos: \(error)")
                return
            }
            
            callback(data!)
        }
    }
    
// Get the current Weather and Forecast Infos using the cityID and returning NSData
    func getWeatherJSON(cityID: String, callback: (NSData, NSData) -> Void) {
        
        // Calling getWeatherInfos function declared above
        getCurrentWeatherInfos(cityID, callback: { responseWeather in
            
            // Then calling getWeatherForecast to do the same
            self.getForecastWeatherInfos(cityID, callback: { responseForecast in
                
                // Returning Filled JSON
                callback(responseWeather,responseForecast)
            })
        })
    }
}