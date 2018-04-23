//
//  AnnotationView.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 7/11/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import Foundation
import MapKit

class AnnotationView: MKAnnotationView{
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if (hitView != nil)
        {
            self.superview?.bringSubview(toFront: self)
        }
        return hitView
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.bounds;
        var isInside: Bool = rect.contains(point);
        if(!isInside)
        {
            for view in self.subviews
            {
                isInside = view.frame.contains(point);
                if isInside
                {
                    break;
                }
            }
        }
        return isInside;
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                // MKMapView.remove(annotation)
                // map.remove(annotation)
                // image = UIImage(named: "")
                
                //                image = UIImage(named: "markerGreen")
                //                print("in AnnotationView Class")
            }
                   }
    }
    
}
