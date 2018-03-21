//
//  MapViewController.swift
//  LocalWeather
//
//  Created by Yury on 3/21/18.
//  Copyright © 2018 Yury Shkoda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(showWeather))
        tap.delegate = self
        tap.numberOfTapsRequired = 2
        
        map.addGestureRecognizer(tap)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func showWeather(sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: map)
        let location = map.convert(tapLocation, toCoordinateFrom: map)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LocationWeather") as? LocationWeatherViewController {
            vc.lat = location.latitude
            vc.lgn = location.longitude
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
