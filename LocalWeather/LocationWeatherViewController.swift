//
//  LocationWeatherViewController.swift
//  LocalWeather
//
//  Created by Yury on 3/21/18.
//  Copyright © 2018 Yury Shkoda. All rights reserved.
//

import UIKit

class LocationWeatherViewController: UIViewController {

    var lat: Double!
    var lgn: Double!
    
    var jsonWeather: JSON! {
        didSet {
            
            guard let lat = lat, let lgn = lgn else { return }
            
            
            temp.text = String(jsonWeather["main"]["temp"].intValue)
            tempMin.text = String(jsonWeather["main"]["temp_min"].intValue)
            tempMax.text = String(jsonWeather["main"]["temp_max"].intValue)
            pressure.text = String(jsonWeather["main"]["pressure"].intValue)
            humidity.text = String(jsonWeather["main"]["humidity"].intValue)
            seaLevel.text = String(jsonWeather["main"]["sea_level"].intValue)
            groundLevel.text = String(jsonWeather["main"]["grnd_level"].intValue)
        }
    }
    
    
    @IBOutlet var temp: UILabel!
    @IBOutlet var tempMax: UILabel!
    @IBOutlet var tempMin: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var seaLevel: UILabel!
    @IBOutlet var groundLevel: UILabel!
    @IBOutlet var humidity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeather()
        
        navigationController?.navigationBar.isHidden = false
    }
    
    func getWeather() {
        
        guard let lat = lat, let lgn = lgn else { return }
        
        if let data = try? String(contentsOf: URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lgn)&appid=b5361a9e6aed5281d0fa5e784af4af96")!) {
            
            jsonWeather = JSON(parseJSON: data)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
