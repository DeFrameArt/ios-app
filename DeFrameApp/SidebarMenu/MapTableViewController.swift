//
//  MapTableViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 4/1/18.
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
class MapTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating  {
    @IBOutlet weak var tableView: UITableView!
    var resultSearchController = UISearchController()
 let controller = UISearchController(searchResultsController: nil)
    var filteredCandies = [Museum]()
  
        override func viewDidLoad() {
           
            self.resultSearchController = ({
               
                controller.searchResultsUpdater = self
                controller.dimsBackgroundDuringPresentation = false
                controller.searchBar.sizeToFit()
                controller.searchBar.barStyle = UIBarStyle.default
                controller.searchBar.barTintColor = UIColor(red: 217/255, green: 63/255, blue: 119/255, alpha:0.5)
                controller.searchBar.backgroundColor = UIColor.clear
                //controller.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
                self.definesPresentationContext = true;
                
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
    
/*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      var seg = self.performSegue(withIdentifier: "mySegueIdentifier", sender: self)
        
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegueIdentifier" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let museum1: Museum
                if isFiltering() {
                    museum1 = filteredCandies[indexPath.row]
                } else {
                    museum1 = museum[indexPath.row]
                }
                let museumViewController = segue.destination as! MuseumViewController
                museumViewController.museumbannerURL = museum1.bannerURL
                museumViewController.museumStreetLabel = museum1.street!
                museumViewController.museumCityStateZipLabel = museum1.zip!
                museumViewController.museumCountryLabel = museum1.country
                museumViewController.museumPageMuseumId = museum1.id
                museumViewController.museumLabel = museum1.name
                museumViewController.logoURL = museum1.logoURL
               // controller1.detailCandy = museum
                museumViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                museumViewController.navigationItem.leftItemsSupplementBackButton = true
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! MuseumListTableViewCell
         let museums: Museum
        
        
        if isFiltering() {
            museums = filteredCandies[indexPath.row]
        } else {
            museums = museum[indexPath.row]
        }
    
        cell.museumLabel.text = museums.name
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

