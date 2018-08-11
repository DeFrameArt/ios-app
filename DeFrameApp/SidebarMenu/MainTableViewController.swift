//
//  MainTableViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 8/7/18.
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

class MainTableViewController:  UITableViewCell  {
  var categories = ["Boston"]
    @IBOutlet weak var carouselMain: UICollectionView!
    
    var tasks = [URLSessionDataTask?]()
    var baseUrl = URL(string: "http://deframe-test-api.us-east-1.elasticbeanstalk.com/museums")!
    
    func urlComponents(index: Int) -> URL {
        
        var baseUrlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        //baseUrlComponents?.path = "/\(screenSize.width)x\(screenSize.height * 0.3)"
        baseUrlComponents?.query = "text=food \(index)"
        return (baseUrlComponents?.url)!
    }
    
    func requestImage(forIndex: IndexPath) {
        var task: URLSessionDataTask
        
        if loadedmusuems?[forIndex.row] != nil {
            // Image is already loaded
            return
        }
        task = getTask(forIndex: forIndex)
        
        task.resume()
        
    }
    
    func getTask(forIndex: IndexPath) -> URLSessionDataTask {
        let imgURL = urlComponents(index: forIndex.row)
        return URLSession.shared.dataTask(with: imgURL) { data, response, error in
            guard let data = data, error == nil else { return }
            
            
            if error == nil {
                
                
                
                do  {
                    
                    let json = try? JSON(data: data)
                    
                    
                    if(json == nil)
                    {
                        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        
                    }
                    else{
                        
                        for result in (json?.arrayValue)! {
                            
                            let id = result["id"].stringValue
                            let name = result["name"].stringValue
                            let acronym = result["acronym"].stringValue
                            let street = result["street"].stringValue
                            let city = result["city"].stringValue
                            let state = result["state"].stringValue
                            let country = result["country"].stringValue
                            let zip = result["zip"].stringValue
                            let lat = result["lat"].doubleValue
                            let lon = result["lng"].doubleValue
                            let bannerURL = result["bannerUrl"].stringValue
                            let logoURL = result["logoUrl"].stringValue
                            
                            
                            
                            let newMuseum = Museum(id:id, name: name, acronym:acronym, street:street, city:city, state:state, country:country, zip:zip, lat: lat, lon: lon, bannerURL: bannerURL, logoURL:logoURL )
                            allMuseums.append(newMuseum)
                            loadedmusuems =  allMuseums
                            
                            DispatchQueue.main.async(execute: {
                                //   completion(self.allMuseums)
                                //self.map.addAnnotations(allMuseums)
                                //self.addMuseumList(self.allMuseums)
                                //     let navController = self.tabBarController?.viewControllers![2] as! UINavigationController
                                //   let vc = navController.topViewController as! ListTableViewController
                                
                                
                                
                                // vc.museum = allMuseums
                                self.carouselMain.reloadItems(at: [forIndex])
                            })
                            
                        }
                    }
                    
                    
                    
                }
                    
                catch {
                    print(error.localizedDescription)
                }
                
            }
            
        }
        
    }
}

extension MainTableViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
return 4
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths{
            requestImage(forIndex: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        //valueToPass = myArray[indexPath.row]
        //print("In \(#function), valueToPass = \(valueToPass)")
        // self.performSegue(withIdentifier: "museumDetails",sender: self)
    }


    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        
    }
    
    func buttonPressed(indexPath: IndexPath){
        
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPageCell", for: indexPath) as! CollectionViewCellMainPage
        
        if let img = loadedmusuems {
           
          //  let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))
            
            cell.imageViewMain.sd_setImage(with: URL(string: img[indexPath.row].bannerURL!))
            //cell.addGestureRecognizer(tapGesture)
           // cell.tapButton=buttonPressed(indexPath: indexPath)
        }
        else {
            requestImage(forIndex: indexPath)
        }
        
        return cell
    }

    
    
}

extension MainTableViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: carouselMain.frame.size.width/3 - 1, height: carouselMain.frame.size.width/3 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

