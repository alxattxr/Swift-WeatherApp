//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alexandre Attar on 2017-3-12.
//  Copyright © 2017 AADevelopment. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var humidityPercentageLabel: UILabel!
    @IBOutlet weak var precipitationPercentageLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let client = APIClient()
    var coordinate = Coordinate(latitude: 0.0, longitude: 0.0)
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
        }
    
        
        locationManager(locationManager)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        getCity(location: location) { (city) in
            self.cityNameLabel.text = city
        }
        
        client.getCurrrentWeather(at: coordinate) {[unowned self] (currentWeather, error) in
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherViewModel(model: currentWeather)
                self.displayWeather(with: viewModel)
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager) {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
            self.coordinate.latitude = (locValue.latitude)
            self.coordinate.longitude = (locValue.longitude)
    }
    
    func getCity(location: CLLocation, completion: @escaping (String) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error)
            } else if let city = placemarks?.first?.locality {
                completion(city)
            }
        }
    }
    
    func displayWeather( with viewModel: CurrentWeatherViewModel){
        self.humidityPercentageLabel.text = viewModel.humidity
        self.precipitationPercentageLabel.text = viewModel.rainChance
        self.tempLabel.text = viewModel.temperature
        self.summaryLabel.text = viewModel.summary
        self.weatherIcon.image = viewModel.icon
    }
}

