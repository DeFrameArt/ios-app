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
import MaterialComponents.MaterialTypography
import Tamamushi
class ListTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UIViewControllerTransitioningDelegate, UITabBarDelegate,AddItemProtocol  {
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
     let transition = BubbleTransition()
   
    @IBOutlet weak var tableView: UITableView!
    var resultSearchController = UISearchController()
    let controller = UISearchController(searchResultsController: nil)
    var filteredCandies = [Museum]()
   
    
    func addItemtoCheckList(_ item:[Museum]){
        museum=item
        //tableView.reloadData()
    }
    
    @IBOutlet weak var viewCell: UIView!
    func setGradientBarWithIndexPath(indexPath: IndexPath, onBar: UINavigationBar) {
        TMGradientNavigationBar().setGradientColorOnNavigationBar(bar: onBar, direction: gradientDirection, typeName: colorNames[indexPath.row])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        UIApplication.shared.statusBarStyle = .lightContent

       self.navigationController?.isNavigationBarHidden = false
        //self.navigationController?.navigationBar.backItem?.backBarButtonItem.te
    self.resultSearchController = ({
    ///search br
    controller.searchResultsUpdater = self
    controller.dimsBackgroundDuringPresentation = false
    controller.hidesNavigationBarDuringPresentation = false
    controller.searchBar.sizeToFit()
    controller.searchBar.barStyle = UIBarStyle.default
        controller.searchBar.placeholder="Search by Museum"

        if #available(iOS 11.0, *) {
           
            let scb = controller.searchBar
            scb.tintColor = UIColor.white
            scb.barTintColor = UIColor.white
            
            if let textfield = scb.value(forKey: "searchField") as? UITextField {
                textfield.textColor = UIColor.blue
                if let backgroundview = textfield.subviews.first {
                    
                    // Background color
                    backgroundview.backgroundColor = UIColor.white
                    
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 10;
                    backgroundview.clipsToBounds = true;
                }
            }
            
          
            navigationItem.titleView = controller.searchBar
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        else {
            // Fallback on earlier versions
           // tableView.tableHeaderView = controller.searchBar
            self.navigationItem.titleView = controller.searchBar
        }
        
        
         self.definesPresentationContext = true;
        
    return controller
    })()
        
        
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 160.0; // set to whatever your "average" cell height is
        
        
        tableView.reloadWithAnimation()
    }
    
    func addItemtoCheckList() {
        //items.append(item)
    
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         UIApplication.shared.statusBarStyle = .lightContent
        TMGradientNavigationBar().setInitialBarGradientColor(direction: .horizontal, startColor: UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0), endColor: UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0))
        setGradientBarWithIndexPath(indexPath: lastSelectedIndexPath, onBar: (navigationController?.navigationBar)!)
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
    if segue.identifier == "museumInfo" {
        let cell1 = sender as! UITableViewCell
        let index1 = tableView.indexPath(for: cell1)
        indexP=(index1?.row)!
    let museum1: Museum
    if isFiltering() {
        museum1 = filteredCandies[indexP]
    } else {
        museum1 = museum[indexP]
    }
    let navVC = segue.destination as? UINavigationController
       

    let museumViewController = navVC?.viewControllers.first as! MuseumViewController
     
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
    var indexP=0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //indexP=indexPath.row
    }

    
 
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
   
      
        return 200 //Not expanded
        
    }
     var viewLad=true
      private var finishedLoadingInitialTableCells = false
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellMuseum", for: indexPath as IndexPath) as! MuseumTableViewCell
     //   cell.infoView.dropShadow()
    let museums: Museum
    
        let modelName = UIDevice.current.modelName2
        
    if isFiltering() {
    museums = filteredCandies[indexPath.row]
    } else {
    museums = museum[indexPath.row]
    }
    let urlImage=museums.logoURL
    cell.titleMuseum.text = museums.name
        if(modelName=="iPhone 5s"){
            cell.titleMuseum.font = MDCTypography.subheadFont()
            cell.titleMuseum.alpha = MDCTypography.display1FontOpacity()
            
            // If using autolayout, the following line is unnecessary as long
            // as all constraints are valid.
             cell.titleMuseum.sizeToFit()
        }
        cell.imageM.sd_setImage(with: URL(string: museums.bannerURL!))
       
        
            
            cell.address.isHidden=false
            var temp : String?
            temp="\(museums.street ?? ""), \(museums.city ?? ""), \(museums.zip ?? "")"
            cell.address.text = temp
             cell.address.font = MDCTypography.subheadFont()
             cell.address.alpha = MDCTypography.subheadFontOpacity()
            
            // If using autolayout, the following line is unnecessary as long
            // as all constraints are valid.
           cell.address.sizeToFit()
    
    return cell
    }
    @IBOutlet weak var CellViewContent: UIView!
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



