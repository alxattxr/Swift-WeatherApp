//
//  CurrentLocation.swift
//  WeatherApp
//
//  Created by Alexandre Attar on 2017-11-15.
//  Copyright © 2017 AADevelopment. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocation {
    var coordinate = Coordinate(latitude: 0.0, longitude: 0.0)
    
    func ourLocation(_ manager: CLLocationManager, _ locations: [CLLocation]) -> Coordinate{
        if let location = locations.first{
            coordinate.longitude = location.coordinate.longitude
            coordinate.latitude = location.coordinate.latitude
        }
        return coordinate
    }
}

