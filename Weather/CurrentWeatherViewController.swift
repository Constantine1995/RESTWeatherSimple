//
//  CurrentWeatherViewController.swift
//  Weather
//
//  Created by mac on 4/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    
    
    @IBOutlet weak var cityTextLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    let forecastAPIKey = "55a266f7ba4e692310514bcba358d0f9"
    let coordinate: (lat: Double, long: Double) = (37.8267, -122.4233)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(latitude: coordinate.lat, longitude: coordinate.long) { currentWeather in
            
            if let currentWeather = currentWeather {
                DispatchQueue.main.async {
                    if let temperature = currentWeather.temperature {
                        self.temperatureLabel.text = "\(temperature)"
                    } else {
                        self.temperatureLabel.text = "-"
                    }
                }
            }
        }
    }
}
