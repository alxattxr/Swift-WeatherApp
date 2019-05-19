//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Alexandre Attar on 2017-3-12.
//  Copyright © 2017 AADevelopment. All rights reserved.
//

import Foundation

struct CurrentWeather{
    let temperature: Double
    let humidity: Double
    let rainChance: Double
    let summary: String
    let icon: String //API Icons property return as string
}

extension CurrentWeather{
    struct apiKey{
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let rainChance = "precipProbability"
        static let city = "timezone"
        static let summary = "summary"
        static let icon = "icon"
    }
    init?(json: [String:AnyObject]){
        guard let tempValue = json[apiKey.temperature] as? Double,
        let humValue = json[apiKey.humidity] as? Double,
        let rainValue = json[apiKey.rainChance] as? Double,
        let summaryString = json[apiKey.summary] as? String,
        let iconString = json[apiKey.icon] as? String else {
            return nil // Since if we are missing a value don't want to return anything
        }
        self.temperature = tempValue
        self.humidity = humValue
        self.rainChance = rainValue
        self.summary = summaryString
        self.icon = iconString
    }
}
