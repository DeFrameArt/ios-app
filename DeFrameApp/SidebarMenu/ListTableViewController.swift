//
//  ListTableViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 4/4/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//
import Foundation
import UIKit
import SwiftyJSON
import MapKit
import CoreLocation
import FBSDKCoreKit
import FBSDKLoginKit
import CoreData
import SDWebImage
import BubbleTransition

class ListTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UIViewControllerTransitioningDelegate  {
     let transition = BubbleTransition()
    @IBOutlet weak var tableView: UITableView!
    var resultSearchController = UISearchController()
    let controller = UISearchController(searchResultsController: nil)
    var filteredCandies = [Museum]()
    
    override func viewDidLoad() {
    
    self.resultSearchController = ({
    ///search br
    controller.searchResultsUpdater = self
    controller.dimsBackgroundDuringPresentation = false
    controller.searchBar.sizeToFit()
    controller.searchBar.barStyle = UIBarStyle.default
    controller.searchBar.barTintColor = UIColor(red: 217/255, green: 63/255, blue: 119/255, alpha:0.5)
    controller.searchBar.backgroundColor = UIColor.clear
    
    self.definesPresentationContext = true;
   // self.tableView.animateTableView(animation: myCoolTableAnimation)
    self.tableView.tableHeaderView = controller.searchBar
    return controller
    })()
    super.viewDidLoad()
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0; // set to whatever your "average" cell height is
    // Setup the Search Controller
    
    
    }
    override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    resultSearchController.dismiss(animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
    
    var museum = [Museum(id:"12", name:"Museum", acronym:"212", street:"Museum", city:"Museum", state:"State", country:"State", zip:"Zip", lat:32.33, lon:32.33, bannerURL:"String", logoURL:"String"), Museum(id:"12", name:"Museum", acronym:"212", street:"Museum", city:"Museum", state:"State", country:"State", zip:"Zip", lat:32.33, lon:32.33, bannerURL:"String", logoURL:"String")]
    func searchBarIsEmpty() -> Bool {
    // Returns true if the text is empty or nil
    return resultSearchController.searchBar.text?.isEmpty ?? true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "selectedMuseum" {
    if let indexPath = tableView.indexPathForSelectedRow {
    let museum1: Museum
    if isFiltering() {
    museum1 = filteredCandies[indexPath.row]
    } else {
    museum1 = museum[indexPath.row]
    }
        let navVC = segue.destination as? UINavigationController
       
   // let  museumViewController = segue.destination as! MuseumViewController
       let museumViewController = navVC?.viewControllers.first as! MuseumViewController
        //let museumViewController = segue.destination as! MuseumViewController
      navVC!.transitioningDelegate = self
      navVC!.modalPresentationStyle = .custom
        
   // let museumViewController = segue.destination as! MuseumViewController
    museumViewController.museumbannerURL = museum1.bannerURL
    museumViewController.museumStreetLabel = museum1.street!
    museumViewController.museumCityStateZipLabel = museum1.zip!
    museumViewController.museumCountryLabel = museum1.country
    museumViewController.museumPageMuseumId = museum1.id
    museumViewController.museumLabel = museum1.name
    museumViewController.logoURL = museum1.logoURL
    // controller1.detailCandy = museum
   
    }
    }
    }
    /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     {
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     
     
     vc.museumbannerURL = self.museumpagebannerURL
     vc.museumStreetLabel = self.museumpagestreetLabel!
     vc.museumCityStateZipLabel = self.museumpageCityStateZipLabel!
     vc.museumCountryLabel = self.museumpageCountryLabel!
     vc.museumPageMuseumId = self.museumId
     vc.museumLabel = self.museumpageNameLabel!
     vc.logoURL = self.museumPagelogoURL
     
     self.navigationController?.pushViewController(vc, animated: true)
     
     }*/
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.bubbleColor =  UIColor.white
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        //transition.startingPoint = someButton.center
        transition.bubbleColor = UIColor.white
        return transition
    }
    
    func filterContentForSearchText(_ searchText: String) {
    filteredCandies = museum.filter({( museum1 : Museum) -> Bool in
    return (museum1.name?.lowercased().contains(searchText.lowercased()))!
    })
    
    tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
    return filteredCandies.count
    }
    
    return museum.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellMuseum", for: indexPath as IndexPath) as! MuseumTableViewCell
    let museums: Museum
    
        let modelName = UIDevice.current.modelName2
        
    if isFiltering() {
    museums = filteredCandies[indexPath.row]
    } else {
    museums = museum[indexPath.row]
    }
    let urlImage=museums.bannerURL
    cell.titleMuseum.text = museums.name
        if(modelName=="iPhone 5s"){
            cell.titleMuseum.font=UIFont(name: "Times New Roman", size: 14.0)
        }
        cell.imageM.sd_setImage(with: URL(string: museums.logoURL!))
         cell.imageM.layer.cornerRadius = ( cell.imageM.frame.size.height/2);
         cell.imageM.layer.masksToBounds = true;
         cell.imageM.layer.borderWidth = 2;
         cell.imageM.layer.borderColor = (UIColor(red: 193/255, green: 77/255, blue: 121/255, alpha: 1)).cgColor
    return cell
    }
    func searchBar(_ searchBar: UISearchBar) {
    filterContentForSearchText(searchBar.text!)
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    
    filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func isFiltering() -> Bool {
    let searchBarScopeIsFiltering = controller.searchBar.selectedScopeButtonIndex != 0
    return controller.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
}

public extension UIDevice {
    
    
    var modelName2: String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            let DEVICE_IS_SIMULATOR = true
        #else
            let DEVICE_IS_SIMULATOR = false
        #endif
        
        var machineString : String = ""
        
        if DEVICE_IS_SIMULATOR == true
        {
            
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineString = dir
            }
        }
        else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            machineString = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        }
        switch machineString {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        default:                                        return machineString
        }
    }
}


