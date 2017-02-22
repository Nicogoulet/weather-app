//
//  CurrentWeatherDecodable.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 10/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation
import Argo
import Curry

// Decodable structures used with Argo to decode JSON containing weather informations
struct CurrentWeatherDecodable {
    let name: String
    let weatherArray: [WeatherDescriptionDecodable]
    let temperature: Int
    let humidity: Int
    let pressure: Int
    let clouds: Int
    let sunrise: Double
    let sunset: Double
    let rain: Int
}

extension CurrentWeatherDecodable: Decodable {
    
    static func decode(json: JSON) -> Decoded<CurrentWeatherDecodable> {
        return curry(CurrentWeatherDecodable.init)
            <^> json <| "name"
            <*> json <|| "weather"
            <*> json <| ["main","temp"]
            <*> json <| ["main","humidity"]
            <*> json <| ["main","pressure"]
            <*> json <| ["clouds","all"]
            <*> json <| ["sys","sunrise"]
            <*> json <| ["sys","sunset"]
            <*> json <| ["rain","1h"] <|> .Success(0)
    }
}

struct WeatherDescriptionDecodable {
    let description: String
}

extension WeatherDescriptionDecodable: Decodable {
    
    static func decode(json: JSON) -> Decoded<WeatherDescriptionDecodable> {
        return curry(WeatherDescriptionDecodable.init)
            <^> json <| "description"
    }
}
