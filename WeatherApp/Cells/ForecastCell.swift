//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 18/05/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var forecastdayLabel: UILabel!
    @IBOutlet weak var forecastMaxTemperatureLabel: UILabel!
    @IBOutlet weak var forecastMinTemperatureLabel: UILabel!
    
    func configure(delegate: ForecastCellContentProtocol) {
        forecastdayLabel.text = delegate.forecastDay
        forecastMaxTemperatureLabel.text = delegate.forecastMaxTemperature
        forecastMinTemperatureLabel.text = delegate.forecastMinTemperature
        
    }
}
