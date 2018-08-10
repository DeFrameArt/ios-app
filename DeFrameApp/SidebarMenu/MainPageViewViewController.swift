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
    
    
    var categories = [""]
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
      // self.mainTable.reloadData()
     //  self.mainTable.rowHeight = UITableViewAutomaticDimension
         UIApplication.shared.statusBarStyle = .lightContent
        //  self.navigationController?.isNavigationBarHidden = false
   // setGradientBackground(name:headerView)
        // Do any additional setup after loading the view.
    }
   // @IBOutlet weak var mainTable: UITableView!
    override func viewDidLayoutSubviews() {
        let gradient = CAGradientLayer()
        gradient.frame.size = self.view.bounds.size
        //gradient.frame = view.bounds
        gradient.frame.size = self.view.bounds.size
        gradient.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        
        view.layer.insertSublayer(gradient, at: 0)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBOutlet weak var headerView: UIView!
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
  
    
   
    
    
    
    var indexP=0
    
    
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var mainCollection: UICollectionView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "museumDetails" {
       
            
            
            
          //  indexP=(index2?.row)!
         
            let navVC = segue.destination as? UINavigationController
            
            
            let museumViewController = navVC?.viewControllers.first as! MuseumViewController
            
            
           // museumViewController.museum=allMuseums
            museumViewController.museumbannerURL = allMuseums[indexP].bannerURL
            museumViewController.museumStreetLabel = allMuseums[indexP].street!
            museumViewController.museumCityStateZipLabel = allMuseums[indexP].zip!
            museumViewController.museumCountryLabel = allMuseums[indexP].country
            museumViewController.museumPageMuseumId = allMuseums[indexP].id
            museumViewController.museumLabel = allMuseums[indexP].name
            museumViewController.logoURL = allMuseums[indexP].logoURL
            print(museumViewController.museumPageMuseumId as Any)
            print(allMuseums[indexP].id as Any)
        }
    }

}
