//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Nicolas Goulet on 30/05/2016.
//  Copyright © 2016 Nicolas Goulet. All rights reserved.
//

import XCTest
import WeatherApp

class WeatherAppTests: XCTestCase {
    
    var expectedCurrentWeatherModel: CurrentWeatherModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Expected Result to compare to
        var expectedForecast: [ForecastModel] = []
        expectedForecast.append(ForecastModel(forecastDay: 1466161200, forecastMinTemperature: 18, forecastMaxTemperature: 25))
        expectedForecast.append(ForecastModel(forecastDay: 1466247600, forecastMinTemperature: 14, forecastMaxTemperature: 21))
        expectedForecast.append(ForecastModel(forecastDay: 1466334000, forecastMinTemperature: 12, forecastMaxTemperature: 17))
        expectedForecast.append(ForecastModel(forecastDay: 1466420400, forecastMinTemperature: 13, forecastMaxTemperature: 18))
        expectedForecast.append(ForecastModel(forecastDay: 1466506800, forecastMinTemperature: 12, forecastMaxTemperature: 20))
        expectedForecast.append(ForecastModel(forecastDay: 1466593200, forecastMinTemperature: 14, forecastMaxTemperature: 24))
        expectedForecast.append(ForecastModel(forecastDay: 1466679600, forecastMinTemperature: 16, forecastMaxTemperature: 27))
        expectedForecast.append(ForecastModel(forecastDay: 1466766000, forecastMinTemperature: 20, forecastMaxTemperature: 29))
        
        expectedCurrentWeatherModel = CurrentWeatherModel(cityName: "Lyon", currentWeather: "clear sky", currentTemperature: 19, detailsSunrise: 1466135419, detailsSunset: 1466191989, detailsClouds: 8, detailsRain: 0, detailsHumidity: 46, detailsPressure: 1012, forecastData: expectedForecast)
    }
    
    func testDecodeJSONWithValidWeatherDataAndValidForecastData() {
        
        // Setup Services
        let testingDecodeService = DecodeService()
        let mockWeatherService = MockWeatherService(validWeather: true, validForecast: true, bundle: NSBundle(forClass: self.dynamicType))
        
        // Setup expectation for async call
        let asyncExpectation = expectationWithDescription("Waiting for callback")
        
        mockWeatherService.getWeatherJSON(Configuration.cityID, callback: { validWeatherData, validForecastData in
            
            do {
                
                try testingDecodeService.decodeJSON(validWeatherData, forecastData: validForecastData, callback: { weatherInfos in
                    
                    XCTAssert(weatherInfos.cityName == self.expectedCurrentWeatherModel.cityName)
                    XCTAssert(weatherInfos.currentTemperature == self.expectedCurrentWeatherModel.currentTemperature)
                    XCTAssert(weatherInfos.currentWeather == self.expectedCurrentWeatherModel.currentWeather)
                    XCTAssert(weatherInfos.detailsClouds == self.expectedCurrentWeatherModel.detailsClouds)
                    XCTAssert(weatherInfos.detailsHumidity == self.expectedCurrentWeatherModel.detailsHumidity)
                    XCTAssert(weatherInfos.detailsRain == self.expectedCurrentWeatherModel.detailsRain)
                    XCTAssert(weatherInfos.detailsPressure == self.expectedCurrentWeatherModel.detailsPressure)
                    XCTAssert(weatherInfos.detailsSunrise == self.expectedCurrentWeatherModel.detailsSunrise)
                    XCTAssert(weatherInfos.detailsSunset == self.expectedCurrentWeatherModel.detailsSunset)
                    XCTAssert(weatherInfos.forecastData.count == self.expectedCurrentWeatherModel.forecastData.count)
                    XCTAssert(weatherInfos.forecastData.first?.forecastDay == self.expectedCurrentWeatherModel.forecastData.first?.forecastDay)
                    XCTAssert(weatherInfos.forecastData.first?.forecastMinTemperature == self.expectedCurrentWeatherModel.forecastData.first?.forecastMinTemperature)
                    XCTAssert(weatherInfos.forecastData.first?.forecastMaxTemperature == self.expectedCurrentWeatherModel.forecastData.first?.forecastMaxTemperature)
                    
                    asyncExpectation.fulfill()
                })
                
            } catch DecodeServiceError.DecodeError {
                XCTFail("Decoding Error")
                
            } catch DecodeServiceError.SerializeError {
                XCTFail("Serializing Error")
            } catch {
                XCTFail("Unexpected Error")
            }
        })
        
        waitForExpectationsWithTimeout(5) { error in
            
            XCTAssertNil(error, "Function not responding: \(error)")
        }
    }
    
    func testDecodeJSONWithNotValidWeatherDataAndValidForecastData () {
        
        // Setup Services
        let testingDecodeService = DecodeService()
        let mockWeatherService = MockWeatherService(validWeather: false, validForecast: true, bundle: NSBundle(forClass: self.dynamicType))
        
        // Setup expectation for async call
        let asyncExpectation = expectationWithDescription("Waiting for callback")
        
        mockWeatherService.getWeatherJSON(Configuration.cityID, callback: { notValidWeatherData, validForecastData in
            
            do {
                
                try testingDecodeService.decodeJSON(notValidWeatherData, forecastData: validForecastData, callback: { weatherInfos in
                    
                    XCTFail("Missing Error Handling")
                    asyncExpectation.fulfill()
                })
                
            } catch is DecodeServiceError {
                XCTAssert(true)
                asyncExpectation.fulfill()


            } catch {
                XCTFail("Unexpected Error")
                asyncExpectation.fulfill()

            }
        })
        
        waitForExpectationsWithTimeout(5) { error in
            
            XCTAssertNil(error, "Function not responding: \(error)")
        }
    }
    
    func testDecodeJSONWithValidWeatherDataAndNotValidForecastData () {
        // Setup Services
        let testingDecodeService = DecodeService()
        let mockWeatherService = MockWeatherService(validWeather: true, validForecast: false, bundle: NSBundle(forClass: self.dynamicType))
        
        // Setup expectation for async call
        let asyncExpectation = expectationWithDescription("Waiting for callback")
        
        mockWeatherService.getWeatherJSON(Configuration.cityID, callback: { validWeatherData, notValidForecastData in
            
            do {
                
                try testingDecodeService.decodeJSON(validWeatherData, forecastData: notValidForecastData, callback: { weatherInfos in
                    
                    XCTFail("Missing Error Handling")
                    asyncExpectation.fulfill()
                })
                
            } catch is DecodeServiceError {
                XCTAssert(true)
                asyncExpectation.fulfill()

                
            } catch {
                XCTFail("Unexpected Error")
                asyncExpectation.fulfill()

            }
        })
        
        waitForExpectationsWithTimeout(5) { error in
            
            XCTAssertNil(error, "Function not responding: \(error)")
        }
    }

    func testDecodeJSONWithNotValidWeatherDataAndNotValidForecastData () {
        
        // Setup Services
        let testingDecodeService = DecodeService()
        let mockWeatherService = MockWeatherService(validWeather: false, validForecast: false, bundle: NSBundle(forClass: self.dynamicType))
            
        // Setup expectation for async call
        let asyncExpectation = expectationWithDescription("Waiting for callback")
            
        mockWeatherService.getWeatherJSON(Configuration.cityID, callback: { notValidWeatherData, notValidForecastData in
                
            do {
                    
                try testingDecodeService.decodeJSON(notValidWeatherData, forecastData: notValidForecastData, callback: { weatherInfos in
                    
                    XCTFail("Missing Error Handling")
                    asyncExpectation.fulfill()
                })
                    
            } catch is DecodeServiceError {
                XCTAssert(true)
                asyncExpectation.fulfill()

            
            } catch {
                XCTFail("Unexpected Error")
                asyncExpectation.fulfill()

            }
        })
            
        waitForExpectationsWithTimeout(5) { error in
                
            XCTAssertNil(error, "Function not responding: \(error)")
        }
    }
    
    func testCurrentWeatherViewModel () {
        
        // Setup Services
        let mockDecodeService = MockDecodeService()
        let mockWeatherService = MockWeatherService(validWeather: true, validForecast: true, bundle: NSBundle(forClass: self.dynamicType))
                
        let testingCurrentWeatherViewModel = CurrentWeatherViewModel(weatherService: mockWeatherService, decodeService: mockDecodeService)
        
        XCTAssert(testingCurrentWeatherViewModel.cityNameDisplay.value == "Lyon")
        XCTAssert(testingCurrentWeatherViewModel.currentWeatherDisplay.value == "clear sky")
        XCTAssert(testingCurrentWeatherViewModel.currentTemperatureDisplay.value == "19°")
        XCTAssert(testingCurrentWeatherViewModel.detailsCloudsDisplay.value == "8 %")
        XCTAssert(testingCurrentWeatherViewModel.detailsHumidityDisplay.value == "46 %")
        XCTAssert(testingCurrentWeatherViewModel.detailsRainDisplay.value == "0 mm")
        XCTAssert(testingCurrentWeatherViewModel.detailsPressureDisplay.value == "1012 hPa")
        XCTAssert(testingCurrentWeatherViewModel.detailsSunriseDisplay.value == "05:50 AM")
        XCTAssert(testingCurrentWeatherViewModel.detailsSunsetDisplay.value == "09:33 PM")
        XCTAssert(testingCurrentWeatherViewModel.forecastDataDisplay.value.count == 8)
        XCTAssert(testingCurrentWeatherViewModel.forecastDataDisplay.value.first?.forecastDay == "Friday")
        XCTAssert(testingCurrentWeatherViewModel.forecastDataDisplay.value.first?.forecastMinTemperature == "18")
        XCTAssert(testingCurrentWeatherViewModel.forecastDataDisplay.value.first?.forecastMaxTemperature == "25")
        

    }
}