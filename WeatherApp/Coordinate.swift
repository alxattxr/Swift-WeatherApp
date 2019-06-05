//
//  Coordinate.swift
//  WeatherApp
//
//  Created by Alexandre Attar on 2017-3-12.
//  Copyright © 2017 AADevelopment. All rights reserved.
//

import Foundation

struct Coordinate{
    var latitude: Double
    var longitude: Double
}

extension Coordinate: CustomStringConvertible {
    var description: String {
            return "\(latitude),\(longitude)"
    }
}



