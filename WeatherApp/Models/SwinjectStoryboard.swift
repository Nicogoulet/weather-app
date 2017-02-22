//
//  SwinjectStoryboard.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 14/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation
import Swinject

extension SwinjectStoryboard {
    
    class func setup() {
        
        defaultContainer.register(WeatherServiceProtocol.self) { _ in WeatherService() }
        defaultContainer.register(DecodeServiceProtocol.self) { _ in DecodeService() }

        defaultContainer.register(CurrentWeatherViewProtocol.self) { r in
            CurrentWeatherViewModel(weatherService: r.resolve(WeatherServiceProtocol)!, decodeService: r.resolve(DecodeServiceProtocol)!)
        }
        
        defaultContainer.registerForStoryboard(MainViewController.self) { r, c in c.mainViewModel = r.resolve(CurrentWeatherViewProtocol.self)
        
        }
    }
}