//
//  MapViewController+Extension.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 7/23/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit
import CoreLocation
import FBSDKCoreKit
import FBSDKLoginKit
import CoreData
import BubbleTransition
import MaterialComponents.MaterialTypography
import DGRunkeeperSwitch
import Tamamushi
import ScalingCarousel

extension MapViewController: MKMapViewDelegate{
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLocation = locations.first
        //print(userLocation)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            // If authorized when in use
            //
            setRegion()
            //            map.addAnnotations(downloadedMuseums)
            //            map.delegate = self
            
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // If always authorized
            manager.startUpdatingLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let museumAnnotation = view.annotation as! Museum
        
    }

    
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation is MKUserLocation
        {
            return nil
        }
        
        
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation.title as? MKAnnotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }
            
        else{
            annotationView?.annotation = annotation
        }
        
        if(annotation is Museum){
            annotationView?.image = UIImage(named: "pinMap")
            
        }
        
        return annotationView
        
    }

    
    func askForLocationAuthorization(){
        if(CLLocationManager.authorizationStatus() == .notDetermined){
            
            locManager.requestWhenInUseAuthorization()
        }
        map.addAnnotations(downloadedMuseums)
       // map.showAnnotations(downloadedMuseums, animated: true)
        map.delegate = self
    }

    func setRegion(){
        
        print(locationManager.location?.coordinate)
        
        let lat = locationManager.location?.coordinate.latitude
        let lng = locationManager.location?.coordinate.longitude
        
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.15, 0.15)
        
        
        print(lat)
        
        if(lat == nil || lng == nil){
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake( 42.343778, -71.09809239999998)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            //map.setCenter((locationManager.location?.coordinate)!, animated:true)
            map.setCenter(location, animated:true)
            map.setRegion(region, animated: true)
            map.regionThatFits(region)
            
        }
        else{
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, lng!)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            map.setCenter((locationManager.location?.coordinate)!, animated:true)
            map.setRegion(region, animated: true)
            map.regionThatFits(region)
            print(userLocation)
            
        }
       
    }
    
   
}
