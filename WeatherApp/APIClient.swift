//
//  APIClient.swift
//  WeatherApp
//
//  Created by Alexandre Attar on 2017-3-12.
//  Copyright © 2017 AADevelopment. All rights reserved.
//

import Foundation

class APIClient{
    let baseUrl = URL(string: "https://api.darksky.net/forecast/cdf97ff3250d724c07f19f03ac3eab0e/")
    
    let downloader = NetworkSessionManager()
    
    func getCurrrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping (CurrentWeather?, NetworkSessionError?) -> Void){
        guard let url = URL(string: coordinate.description, relativeTo: baseUrl) else {
            completion(nil, .invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = downloader.networkTask(with: request) { (json, error) in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let currentWeatherJSON = json["currently"] as? [String:AnyObject], let currentWeather = CurrentWeather(json: currentWeatherJSON) else {
                    completion(nil, .parsingError)
                    return
                }
                completion(currentWeather, nil)
            }
        }
        
        task.resume()
    }
}
