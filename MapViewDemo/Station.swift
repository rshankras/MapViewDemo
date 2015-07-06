//
//  Station.swift
//  MapViewDemo
//
//  Created by Ravi Shankar on 06/07/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import MapKit

class Station: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude:Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
