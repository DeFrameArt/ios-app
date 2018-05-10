//
//  PrivacyViewController.swift
//  DeFrameApp
//
//  Created by Ankur Bag on 11/11/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!

    
    private func imageLayerForGradientBackground() -> UIImage {
        
        var updatedFrame = navigationController?.navigationBar.bounds
        // take into account the status bar
        updatedFrame?.size.height += 20
        var layer = CAGradientLayer.gradientLayerForBounds(bounds: updatedFrame!)
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            //navigationController?.navigationBar.barTintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = UIColor.white
            let fontDictionary = [ NSForegroundColorAttributeName:UIColor.white ]
            navigationController?.navigationBar.titleTextAttributes = fontDictionary
            navigationController?.navigationBar.setBackgroundImage(imageLayerForGradientBackground(), for: UIBarMetrics.default)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
extension CAGradientLayer {
    class func gradientLayerForBounds(bounds: CGRect) -> CAGradientLayer {
        var layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        return layer
    }
}
