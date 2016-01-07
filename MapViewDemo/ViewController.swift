//
//  ViewController.swift
//  MapViewDemo
//
//  Created by Ravi Shankar on 06/07/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomToRegion()
        
        let annotations = getMapAnnotations()
        
        // Add mappoints to Map
        mapView.addAnnotations(annotations)
        
        mapView.delegate = self
        
        // Connect all the mappoints using Poly line.
        
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        
        for annotation in annotations {
            points.append(annotation.coordinate)
        }
        
        
        let polyline = MKPolyline(coordinates: &points, count: points.count)
        
        mapView.addOverlay(polyline)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Zoom to region
    
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 13.03297, longitude: 80.26518)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        
        mapView.setRegion(region, animated: true)
    }
    
    //MARK:- Annotations
    
    func getMapAnnotations() -> [Station] {
        var annotations:Array = [Station]()
        
        //load plist file
        
        var stations: NSArray?
        if let path = NSBundle.mainBundle().pathForResource("stations", ofType: "plist") {
            stations = NSArray(contentsOfFile: path)
        }
        if let items = stations {
            for item in items {
                let lat = item.valueForKey("lat") as! Double
                let long = item.valueForKey("long")as! Double
                let annotation = Station(latitude: lat, longitude: long)
                annotation.title = item.valueForKey("title") as? String
                annotations.append(annotation)
            }
        }
        
        return annotations
    }
    
    //MARK:- MapViewDelegate methods
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        if overlay is MKPolyline {
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 5

        }
        return polylineRenderer
    }
}

