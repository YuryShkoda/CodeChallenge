//
//  ViewController.swift
//  LocalWeather
//
//  Created by Yury on 3/21/18.
//  Copyright © 2018 Yury Shkoda. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    var lat: Double!
    var lgn: Double! {
        didSet {
            getWeather()
        }
    }
    
    var jsonWeather: JSON! {
        didSet {
            temp.text = String(jsonWeather["main"]["temp"].intValue)
            tempMin.text = String(jsonWeather["main"]["temp_min"].intValue)
            tempMax.text = String(jsonWeather["main"]["temp_max"].intValue)
            pressure.text = String(jsonWeather["main"]["pressure"].intValue)
            humidity.text = String(jsonWeather["main"]["humidity"].intValue)
            seaLevel.text = String(jsonWeather["main"]["sea_level"].intValue)
            groundLevel.text = String(jsonWeather["main"]["grnd_level"].intValue)
        }
    }
    
    @IBOutlet var currentLocationLabel: UILabel!
    @IBOutlet var temp: UILabel!
    @IBOutlet var tempMax: UILabel!
    @IBOutlet var tempMin: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var seaLevel: UILabel!
    @IBOutlet var groundLevel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
           
           print(locationManager)
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        lat = location.latitude
        lgn = location.longitude
        
        currentLocationLabel.text = "Weather for location: \nlatitude = \(String(format: "%.5f", lat))\nlongitude = \(String(format: "%.5f", lgn))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getWeather() {
        
        guard let lat = lat, let lgn = lgn else { return }
      
        if let data = try? String(contentsOf: URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lgn)&appid=b5361a9e6aed5281d0fa5e784af4af96")!) {
            
            jsonWeather = JSON(parseJSON: data)
        }
    }
}

