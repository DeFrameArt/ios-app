//
//  ViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 6/30/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit

class ViewControllerTab: UITabBarController {

    let button = UIButton.init(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //button.setTitle("Cam", for: .normal)
       // button.setTitleColor(.black, for: .normal)
       //button.setTitleColor(.yellow, for: .highlighted)
        
        //button.backgroundColor = .orange
        button.layer.cornerRadius = 32
       button.layer.borderWidth = 1
       // button.layer.borderColor = UIColor.yellow.cgColor
        let image = UIImage(named: "Bot Button") as UIImage?
        
        //button.frame = CGRectMake(100, 100, 100, 100)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        //button.backgroundImage(for: #imageLiteral(resourceName: "robot.png"))
        self.view.insertSubview(button, aboveSubview: self.tabBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // safe place to set the frame of button manually
        button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 74, width: 64, height: 64)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


