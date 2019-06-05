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

class MainViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var humidityPercentageLabel: UILabel!
    @IBOutlet weak var precipitationPercentageLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var locationStackView: UIStackView!
    @IBOutlet weak var temperatureStackView: UIStackView!
    @IBOutlet weak var humidityStackView: UIStackView!
    @IBOutlet weak var precipitationStackView: UIStackView!
    
    let locationManager = CLLocationManager()
    let client = APIClient()
    var coordinate = Coordinate(latitude: 0.0, longitude: 0.0)
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //Since we added the AVPreviewLayer to our MainView as a sublayer we need to bring up eveything back over the added sublayer
        view.layer.addSublayer(locationStackView.layer)
        view.layer.addSublayer(temperatureStackView.layer)
        view.layer.addSublayer(humidityStackView.layer)
        view.layer.addSublayer(precipitationStackView.layer)

        
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
}


extension MainViewController {
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
    
    func displayWeather(with viewModel: CurrentWeatherViewModel) {
        self.humidityPercentageLabel.text = viewModel.humidity
        self.precipitationPercentageLabel.text = viewModel.rainChance
        self.tempLabel.text = viewModel.temperature
        self.summaryLabel.text = viewModel.summary
        self.weatherIcon.image = viewModel.icon
    }
}
