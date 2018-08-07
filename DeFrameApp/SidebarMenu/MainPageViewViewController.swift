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

class MainPageViewViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
 var gradient: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
         UIApplication.shared.statusBarStyle = .lightContent
        //  self.navigationController?.isNavigationBarHidden = false
   // setGradientBackground(name:headerView)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        let gradient = CAGradientLayer()
        gradient.frame.size = self.headerView.bounds.size
        //gradient.frame = view.bounds
        gradient.frame.size = self.headerView.bounds.size
        gradient.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        
        headerView.layer.insertSublayer(gradient, at: 0)
        
        
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
    
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPageCell", for: indexPath) as! CollectionViewCellMainPage
        
    if let img = loadedmusuems {
       
        cell.imageViewMain.sd_setImage(with: URL(string: img[indexPath.row].bannerURL!))
        
    }
    else {
        requestImage(forIndex: indexPath)
    }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths{
            requestImage(forIndex: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainCollection.frame.size.width/3 - 1, height: mainCollection.frame.size.width/3 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    @IBOutlet weak var mainCollection: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let commentView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mainHeader", for: indexPath) as! CollectionReusableViewMainPage
       // setGradientBackground(name:commentView.headView)
        
        return commentView
        
    }
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
                        self.present(alert, animated: true, completion: nil)
                        
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
                                self.mainCollection.reloadItems(at: [forIndex])
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "selectedCity"{
            let museumListViewController = segue.destination as! ListTableViewController
            museumListViewController.museum=allMuseums
            
        }
    
    }
}
