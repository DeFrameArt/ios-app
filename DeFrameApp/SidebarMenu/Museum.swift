//
//  Museum.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 7/8/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Museum: NSObject, MKAnnotation {
    
    var id: String?
    var name: String?
    var acronym: String?
    var street: String?
    var city: String?
    var state: String?
    var country: String?
    var zip: String?
    var lat:Double?
    var lon:Double?
    var bannerURL: String?
    var logoURL: String?
    var coordinate: CLLocationCoordinate2D
    
    
    init(id: String, name:String, acronym:String, street: String, city: String, state: String, country: String, zip: String, lat:Double, lon:Double, bannerURL:String, logoURL: String){
        
        self.id = id
        self.name = name
        self.acronym = acronym
        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.zip = zip
        self.lat = lat
        self.lon = lon
        self.bannerURL = bannerURL
        self.logoURL = logoURL
        self.coordinate =  CLLocationCoordinate2D(latitude: self.lat!, longitude: self.lon!)
        
    }


}
