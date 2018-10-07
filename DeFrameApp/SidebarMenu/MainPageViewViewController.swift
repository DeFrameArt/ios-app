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
    
  // @IBOutlet weak var headerView: UIView!
    
  var categories = ["Boston","Moscow","Boston","Moscow"]
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
       
        let modelName = UIDevice.current.modelName2
        if(modelName=="iPhone 5s"){
            maxHeaderHeight = 300
        }
      
       // self.mainTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
       /* backGroundColor.layer.shadowOpacity = 0.5
        backGroundColor.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        backGroundColor.layer.shadowRadius = 5.0
        backGroundColor.layer.shadowColor = UIColor.black.cgColor */
        
      //  setGradientBackground(name: headerView)
      // self.mainTable.reloadData()
     //  self.mainTable.rowHeight = UITableViewAutomaticDimension
         UIApplication.shared.statusBarStyle = .lightContent
        //  self.navigationController?.isNavigationBarHidden = false
  //  setGradientBackground(name:headerView)
        // Do any additional setup after loading the view.
    }
   // @IBOutlet weak var mainTable: UITableView!
    override func viewDidLayoutSubviews() {
      
        
        
    }
   
    @IBOutlet weak var logoImage: UIImageView!
    
  //  @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    // @IBOutlet weak var logo: UIImageView!
 //   @IBOutlet weak var logo: UIImageView!
    var maxHeaderHeight: CGFloat = 170
    @IBOutlet weak var titleDeframe: UILabel!
    let minHeaderHeight: CGFloat = 44;
    @IBOutlet weak var backGroundColor: UIImageView!
   // @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.isNavigationBarHidden = true
       // self.headerHeightConstraint.constant = 0
      let modelName = UIDevice.current.modelName2
        if(modelName=="iPhone 6s"){
            maxHeaderHeight = 200
        }
        if(modelName=="iPhone 5s"){
            maxHeaderHeight = 170
        }
        
        self.headerHeightConstraint.constant = self.maxHeaderHeight
       updateHeader()
    }
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        if canAnimateHeader(scrollView) {
            
            // Calculate new header height
            var newHeight = self.headerHeightConstraint.constant
            if isScrollingDown {
                newHeight = max(self.minHeaderHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
                //logo.isHidden = true
            } else if isScrollingUp {
                newHeight = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
                //logo.isHidden = false
            }
            
            // Header needs to animate LocationList
            if newHeight != self.headerHeightConstraint.constant {
                self.headerHeightConstraint.constant = newHeight
                self.updateHeader()
                self.setScrollPosition(self.previousScrollOffset)
            }
            
            self.previousScrollOffset = scrollView.contentOffset.y
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidStopScrolling() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)
        
        if self.headerHeightConstraint.constant > midPoint {
            self.expandHeader()
        } else {
            self.collapseHeader()
        }
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        // Calculate the size of the scrollView when header is collapsed
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight
        
        // Make sure that when header is collapsed, there is still room to scroll
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func collapseHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func setScrollPosition(_ position: CGFloat) {
        self.mainTable.contentOffset = CGPoint(x: self.mainTable.contentOffset.x, y: position)
    }
    
    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.headerHeightConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
        if (self.headerHeightConstraint.constant == minHeaderHeight){
            logo.isHidden=true
            background.isHidden=true
        }
        else{
            logo.isHidden=false
            background.isHidden=false
        }
        //self.titleTopConstraint.constant = -openAmount + 10
      //  self.logoImage.alpha = percentage
    }
    
    @IBOutlet weak var DefreameTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setGradientBackground(name:UIView) {
        let colorTop =  UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor
        let colorBottom = UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom];
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.view.bounds
        name.layer.addSublayer(gradientLayer)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

       
        
        
        if(segue.identifier == "LocationList"){
            let museumListViewController = segue.destination as! ListTableViewController
            museumListViewController.museum=allMuseums
            
        }
        
    }
    
   
    @IBOutlet weak var collectionCities: UICollectionView!

   
    
    var previousScrollOffset: CGFloat = 0;
    
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
   
    var indexP=0
    
  //  @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var mainTable: UITableView!
    
    //@IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var mainCollection: UICollectionView!
 

}
