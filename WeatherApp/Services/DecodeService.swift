//
//  DecodeService.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 17/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation
import Argo

struct DecodeService: DecodeServiceProtocol {
    
    // Used in decodeJSON. Decode Weather Infos then call callback function
    private func decodeWeatherJSON(weatherData: NSData) throws -> CurrentWeatherDecodable {
        
        do {
            let weatherJSON: AnyObject = try NSJSONSerialization.JSONObjectWithData(weatherData, options: [])
            if let weatherDataDecoded: CurrentWeatherDecodable? = decode(weatherJSON) {
                return(weatherDataDecoded!)
            } else {
                throw DecodeServiceError.DecodeError
            }
        } catch {
            throw DecodeServiceError.SerializeError
        }
    }
    
    // Used in decodeJSON. Decode Forecast Infos then call callback function
    private func decodeForecastJSON(forecastData: NSData) throws -> ForecastDecodable {
        
        do {
            let forecastJSON: AnyObject = try NSJSONSerialization.JSONObjectWithData(forecastData, options: [])
            if let forecastDataDecoded: ForecastDecodable? = decode(forecastJSON) {
                return(forecastDataDecoded!)
            } else {
                throw DecodeServiceError.DecodeError
            }
        } catch {
            throw DecodeServiceError.SerializeError
        }
    }
    
    // Function Decoding JSON files received from API then callback with filled WeatherInfoModel
    func decodeJSON(weatherData: NSData, forecastData: NSData, callback: CurrentWeatherModel -> Void) throws {
        
        do {
            // Decoding Weather Infos
            let weatherDataDecoded = try decodeWeatherJSON(weatherData)
            
            // Decoding Forecast Infos
            let forecastDataDecoded = try decodeForecastJSON(forecastData)
            var forecastArray: [ForecastModel] = []
            for forecastInfos in forecastDataDecoded.forecastArray {
                forecastArray.append(ForecastModel(forecastDay: forecastInfos.date, forecastMinTemperature: forecastInfos.minTemp, forecastMaxTemperature: forecastInfos.maxTemp))
            }
            
            callback(CurrentWeatherModel(cityName: weatherDataDecoded.name, currentWeather: weatherDataDecoded.weatherArray.first!.description, currentTemperature: weatherDataDecoded.temperature, detailsSunrise: weatherDataDecoded.sunrise, detailsSunset: weatherDataDecoded.sunset, detailsClouds: weatherDataDecoded.clouds, detailsRain: weatherDataDecoded.rain , detailsHumidity: weatherDataDecoded.humidity, detailsPressure: weatherDataDecoded.pressure, forecastData: forecastArray))
            
        } catch DecodeServiceError.DecodeError {
            throw DecodeServiceError.DecodeError
        } catch DecodeServiceError.SerializeError {
            throw DecodeServiceError.SerializeError
        }
    }
}