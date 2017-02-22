//
//  CurrentWeatherViewProtocol.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 15/06/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


// ViewModel to display Weather Data
protocol CurrentWeatherViewProtocol {
    
    var cityNameDisplay: Variable<String> { get }
    var currentWeatherDisplay: Variable<String> { get }
    var currentTemperatureDisplay: Variable<String> { get }
    var detailsSunriseDisplay: Variable<String> { get }
    var detailsSunsetDisplay: Variable<String> { get }
    var detailsCloudsDisplay: Variable<String> { get }
    var detailsRainDisplay: Variable<String> { get }
    var detailsHumidityDisplay: Variable<String> { get }
    var detailsPressureDisplay: Variable<String> { get }
    
    var forecastDataDisplay: Variable<[ForecastViewModel]> { get }
        
}