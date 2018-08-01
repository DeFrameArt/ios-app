//
//  MapViewControllerCarousel+Extension.swift
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

extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate,UICollectionViewDataSourcePrefetching {
    
   
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
     
        for indexPath in indexPaths{
            requestImage(forIndex: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return 4
    }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: collectionView.frame.size.width/3 - 1, height: collectionView.frame.size.width/3 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scrolling", for: indexPath) as! CarouselCollectionViewCell
        
        if let img = loadedmusuems {
            cell.museumCity.text=img[indexPath.row].city
            cell.museumName.text=img[indexPath.row].name
            cell.museumStreet.text=img[indexPath.row].street
            cell.museumImage.sd_setImage(with: URL(string: img[indexPath.row].bannerURL!))
           
            cell.museumName.font = MDCTypography.subheadFont()
            /// titleFont()
            cell.museumName.alpha = MDCTypography.titleFontOpacity()
            
            // If using autolayout, the following line is unnecessary as long
            // as all constraints are valid.
                cell.museumName.sizeToFit()
            
            
            cell.museumCity.font = MDCTypography.captionFont()
            cell.museumCity.alpha = MDCTypography.body1FontOpacity()
            
            // If using autolayout, the following line is unnecessary as long
            // as all constraints are valid.
            cell.museumCity.sizeToFit()
            
            cell.museumStreet.font = MDCTypography.captionFont()
            cell.museumStreet.alpha = MDCTypography.body1FontOpacity()
            cell.museumStreet.sizeToFit()
        }
        else {
            requestImage(forIndex: indexPath)
        }
        return cell
    }
    


}

