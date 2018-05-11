//
//  PrivacyViewController.swift
//  DeFrameApp
//
//  Created by Ankur Bag on 11/11/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import UIKit
import Tamamushi

class PrivacyViewController: UIViewController {
    @IBAction func CloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var menuButton:UIBarButtonItem!
    let colorNames = [
        "SoundCloud",
        "Facebook Messenger",
        "Flickr",
        "Vine",
        "YouTube",
        "Pinky",
        "Sunrise",
        "Playing with Reds",
        "Ukraine",
        "Curiosity blue",
        "Between Night and Day",
        "Timber",
        "Passion",
        "Master Card",
        "Green and Blue",
        "Inbox",
        "Little Leaf",
        "Alihossein",
        "Endless River",
        "Kyoto",
        "Twitch"
    ]
    var lastSelectedIndexPath = IndexPath(row: 0, section: 0)
    var gradientDirection = Direction.vertical
   
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
      
        }
      
        TMGradientNavigationBar().setInitialBarGradientColor(direction: .horizontal, startColor: UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0), endColor: UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0))
        setGradientBarWithIndexPath(indexPath: lastSelectedIndexPath, onBar: (navigationController?.navigationBar)!)
    }
    func setGradientBarWithIndexPath(indexPath: IndexPath, onBar: UINavigationBar) {
        TMGradientNavigationBar().setGradientColorOnNavigationBar(bar: onBar, direction: gradientDirection, typeName: colorNames[indexPath.row])
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
        layer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        return layer
    }
}
