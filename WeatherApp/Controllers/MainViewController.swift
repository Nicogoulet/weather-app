//
//  ViewController.swift
//  WeatherApp
//
//  Created by Nicolas Goulet on 12/05/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var sunriseValueLabel: UILabel!
    @IBOutlet weak var sunsetValueLabel: UILabel!
    @IBOutlet weak var cloudsValueLabel: UILabel!
    @IBOutlet weak var rainValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var pressionValueLabel: UILabel!
        
    @IBOutlet weak var forecastTableView: UITableView!
    
    var mainViewModel: CurrentWeatherViewProtocol!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Binding Labels to the View Model data
        mainViewModel.cityNameDisplay
            .asObservable()
            .bindTo(cityNameLabel.rx_text)
            .addDisposableTo(disposeBag)

        mainViewModel.currentTemperatureDisplay
            .asObservable()
            .bindTo(currentTemperatureLabel.rx_text)
            .addDisposableTo(disposeBag)

        mainViewModel.currentWeatherDisplay
            .asObservable()
            .bindTo(currentWeatherLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        mainViewModel.detailsSunriseDisplay
            .asObservable()
            .bindTo(sunriseValueLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        mainViewModel.detailsSunsetDisplay
            .asObservable()
            .bindTo(sunsetValueLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        mainViewModel.detailsCloudsDisplay
            .asObservable()
            .bindTo(cloudsValueLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        mainViewModel.detailsRainDisplay
            .asObservable()
            .bindTo(rainValueLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        mainViewModel.detailsHumidityDisplay
            .asObservable()
            .bindTo(humidityValueLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        mainViewModel.detailsPressureDisplay
            .asObservable()
            .bindTo(pressionValueLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        mainViewModel.forecastDataDisplay
            .asObservable()
            .bindTo(forecastTableView
                .rx_itemsWithCellIdentifier("forecastCell", cellType: ForecastCell.self)
            )
            { (row, element, cell) in
                cell.configure(element)
            }
            .addDisposableTo(disposeBag)
        
    }
}