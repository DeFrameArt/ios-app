//
//  AccountViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 5/9/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var logOut: UIView!
    @IBOutlet weak var privacyView: UIView!
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var tabSection: UIView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    var gradient: CAGradientLayer!
    
    
    override func viewDidLayoutSubviews() {
        let gradient = CAGradientLayer()
        gradient.frame.size = self.viewImage.bounds.size
        //gradient.frame = view.bounds
        gradient.frame.size = self.viewImage.bounds.size
        gradient.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        
        viewImage.layer.insertSublayer(gradient, at: 0)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        viewImage.layer.shadowOpacity = 0.5
        viewImage.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        viewImage.layer.shadowRadius = 5.0
        viewImage.layer.shadowColor = UIColor.black.cgColor
        
        tabView.layer.shadowOpacity = 0.5
        tabView.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        tabView.layer.shadowRadius = 5.0
        tabView.layer.shadowColor = UIColor.lightGray.cgColor
        //imageProfile.dropShadow()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIView {
    
    // OUTPUT 1
    func dropShadow1(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
