//
//  PhotoViewController.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 7/8/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import UIKit

class TermsAndConditionViewController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    @IBAction func CloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            navigationController?.navigationBar.barTintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
            
        }
        textView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
