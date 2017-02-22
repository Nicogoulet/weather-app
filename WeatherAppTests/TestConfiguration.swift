//
//  TestConfiguration.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 30/05/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation

struct Configuration {
    
    struct Api {
        static let authKey = "cfe05109fd2bb05c1158eba057ebbd6f"
    }
    
    struct WebService {
        static let urlRoot = "http://api.openweathermap.org/data/2.5/"
        static let weatherURL = "weather"
        static let forecastURL = "forecast/daily"
    }
    static let cityID = "2996944"
}