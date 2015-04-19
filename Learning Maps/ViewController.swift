//
//  ViewController.swift
//  Learning Maps
//
//  Created by Gerardo Camilo on 19/1/15.
//  Copyright (c) 2015 ___GRCS___. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

