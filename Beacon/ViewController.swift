//
//  ViewController.swift
//  Beacon
//
//  Created by Dat Bui on 2/6/18.
//  Copyright © 2018 Dat Bui. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

var locationManager = CLLocationManager()

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLocation = locationManager.location
        // Do any additional setup after loading the view, typically from a nib.
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 18)
        let mapView = GMSMapView.map(withFrame: .zero, camera:camera)
        self.view = mapView
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        mapView.animate(toViewingAngle: 30)
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }
            else {
                NSLog("Unable to find style.json")
            }
        }
        catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        self.view = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    

}

