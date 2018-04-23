//
//  MuseumDetailsView.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 9/25/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import Foundation
import UIKit

class MuseumDetailsView: UIView {
    
    // @IBOutlet var starbucksImage: UIImageView!
    
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var streetLabel: UILabel!
    
    @IBOutlet var cityStreetZip: UILabel!
    
    @IBOutlet var countryLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        
        self.layoutIfNeeded()
        layer.cornerRadius = self.frame.height / 9.0
        layer.masksToBounds = true
        layer.borderWidth = 1
        // layer.borderColor = UIColor.black.cgColor
        layer.borderColor = UIColor(red: 10/255.0, green: 44/255.0, blue: 99/255.0, alpha: 1.0).cgColor
        
    }
    
    
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
}
