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

    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            navigationController?.navigationBar.barTintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
