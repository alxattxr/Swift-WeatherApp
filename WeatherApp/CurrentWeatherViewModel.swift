//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Alexandre Attar on 2017-3-12.
//  Copyright © 2017 AADevelopment. All rights reserved.
//

import Foundation
import UIKit

//Formats our data
struct CurrentWeatherViewModel {
    let temperature: String
    let humidity: String
    let rainChance: String
    let summary: String
    let icon: UIImage
    
    init(model: CurrentWeather){
        let displayedTemp = Int(((model.temperature) - 32)/(9/5))
        let humidityPercent = Int(model.humidity * 100)
        let rainChancePercent = Int(model.rainChance * 100)
        let displayedIcon = WeatherIcon(iconStr: model.icon)
        
        self.temperature = "\(displayedTemp)°"
        self.humidity = "\(humidityPercent)%"
        self.rainChance = "\(rainChancePercent)%"
        self.summary = model.summary
        self.icon = displayedIcon.image
    }
}
