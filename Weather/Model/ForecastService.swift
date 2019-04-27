//
//  ForecastService.swift
//  Weather
//
//  Created by mac on 4/26/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class ForecastService {
    let forecastAPIKey: String
    let forecastBaseURL: URL?
    
    // forecastBaseURL / forecastAPIKey / latitude, longitude
    init(APIKey: String) {
        self.forecastAPIKey = APIKey
        forecastBaseURL = URL(string: "https://api.darksky.net/forecast/\(APIKey)")
    }
    
    func getForecast(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> Void) {
        if let forecastURL = URL(string: "\(forecastBaseURL!)/\(latitude),\(longitude)") {
            let networkProcessor = NetworkProcessor(url: forecastURL)
            networkProcessor.downloadJSONFromURL { jsonDictionary in
                if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String : Any] {
                    let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                    completion(currentWeather)
                } else {
                    completion(nil)
                }
            }
        }
        
    }
}
