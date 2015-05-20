//
//  ViewController.swift
//  Learning Maps
//
//  Created by Gerardo Camilo on 19/1/15.
//  Copyright (c) 2015 ___GRCS___. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        var lat:CLLocationDegrees = 18.448080;
        var lon:CLLocationDegrees = -69.942769;
        
        var latDelta:CLLocationDegrees = 0.05;
        var lonDelta:CLLocationDegrees = 0.05;
        
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon);
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta);
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation();
        annotation.coordinate = location;
        annotation.title = "Parque Mirador Sur";
        annotation.subtitle = "El mejor para actividades al aire libre";
        
        map.addAnnotation(annotation);
        
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:");
        uilpgr.minimumPressDuration = 2;
        map.addGestureRecognizer(uilpgr);
    }
    
    
    func action(gestureRecognizer: UILongPressGestureRecognizer){
        println("Gesture recognized");
            
        var touchPoint = gestureRecognizer.locationInView(self.map);
        var newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map);

        var annotation = MKPointAnnotation();
        annotation.title = "New place in Map";
        annotation.subtitle = "Added by user";
        annotation.coordinate = newCoordinate;
        
        map.addAnnotation(annotation);
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations);
        
        var userLocation : CLLocation = locations[0] as! CLLocation;
        var userLatitude = userLocation.coordinate.latitude;
        var userLongitude = userLocation.coordinate.longitude;
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLatitude, userLongitude);
        
        var latDelta:CLLocationDegrees = 0.01;
        var lonDelta:CLLocationDegrees = 0.01;
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta);
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        var speed = userLocation.speed;
        var latitude = userLocation.coordinate.latitude;
        var longitude = userLocation.coordinate.longitude;

        println("Speed: \(speed)");
        println("Lat: " + latitude.description);
        println("Lon: " + longitude.description);
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler:
        {(placemarks, error)-> Void in
            if error != nil {
                println("Error in geodecoder: " + "Supposed error message");
                return;
            }

            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark;
                self.displayLocationInfo(pm);
            } else {
                println("No location available this time.");
            }
            
        })
        
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
        var subThoroughfare = "";
        
        if (placemark.subThoroughfare != nil ){
            subThoroughfare = placemark.subThoroughfare;
        }
        
        var address = "\(subThoroughfare) \(placemark.thoroughfare) \(placemark.locality) \(placemark.subLocality)         \(placemark.administrativeArea) \(placemark.subAdministrativeArea)";


        println("Address: " + address);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

