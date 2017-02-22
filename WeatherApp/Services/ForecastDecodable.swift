//
//  ForecastDecodable.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 10/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation
import Argo
import Curry

// Decodable structures used with Argo to decode JSON containing forecast informations
struct ForecastDecodable {
    let forecastArray: [ForecastData]
}

extension ForecastDecodable: Decodable {
    
    static func decode(json: JSON) -> Decoded<ForecastDecodable> {
        return curry(ForecastDecodable.init)
            <^> json <|| "list"
    }
}

struct ForecastData {
    let date: Double
    let minTemp: Int
    let maxTemp: Int
}

extension ForecastData: Decodable {
    
    static func decode(json: JSON) -> Decoded<ForecastData> {
        return curry(ForecastData.init)
            <^> json <| "dt"
            <*> json <| ["temp","min"]
            <*> json <| ["temp","max"]
    }
}