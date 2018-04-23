//
//  locationAnnotation.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 7/10/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import Foundation
import MapKit

class locationAnnotation: NSObject, MKAnnotation {
    
    var name: String?
    var lat:Double?
    var lon:Double?
    var imageName: String?
    var coordinate: CLLocationCoordinate2D
    
    
    init(name:String, lat:Double, lon:Double, imageName:String){
        
        self.name = name
        self.lat = lat
        self.lon = lon
        self.imageName = imageName
        self.coordinate =  CLLocationCoordinate2D(latitude: self.lat!, longitude: self.lon!)
        
    }
    
    
}
