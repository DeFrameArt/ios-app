//
//  MainPageViewViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 8/5/18.
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
var indexP=0

class MainPageViewViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var headerView: UIView!
    
  var categories = [""]
   // func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     //   return categories[section]
   // }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! MainTableViewController
        return cell
    }
    
 var gradient: CAGradientLayer!
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
      
       // self.mainTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        backGroundColor.layer.shadowOpacity = 0.5
        backGroundColor.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        backGroundColor.layer.shadowRadius = 5.0
        backGroundColor.layer.shadowColor = UIColor.black.cgColor
        
      //  setGradientBackground(name: headerView)
      // self.mainTable.reloadData()
     //  self.mainTable.rowHeight = UITableViewAutomaticDimension
         UIApplication.shared.statusBarStyle = .lightContent
        //  self.navigationController?.isNavigationBarHidden = false
   // setGradientBackground(name:headerView)
        // Do any additional setup after loading the view.
    }
   // @IBOutlet weak var mainTable: UITableView!
    override func viewDidLayoutSubviews() {
      
        
        
    }
    @IBOutlet weak var backGroundColor: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.isNavigationBarHidden = true
    }
   // @IBOutlet weak var headerView: UIView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setGradientBackground(name:UIView) {
        let colorTop =  UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor
        let colorBottom = UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        name.layer.addSublayer(gradientLayer)
    }
   
   
    @IBOutlet weak var collectionCities: UICollectionView!

    
    var indexP=0
    
    
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var mainCollection: UICollectionView!
 

}
