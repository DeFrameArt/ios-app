//
//  MapViewController.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 7/8/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
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


//protocol AddItemProtocol {
    //code for the requirements of this protocole
  //  func addMusuem(_ item:SelectedMuseum)
//}
var allMuseums:[Museum] = [Museum]()
var loadedmusuems:[Museum]?
protocol AddItemProtocol {
    //code for the requirements of this protocole
    func addItemtoCheckList(_ item:[Museum])
}

class MapViewController: UIViewController, CLLocationManagerDelegate, UIViewControllerTransitioningDelegate,UITabBarControllerDelegate {

    var tasks = [URLSessionDataTask?]()
    var baseUrl = URL(string: "http://deframe-test-api.us-east-1.elasticbeanstalk.com/museums")!
    
    
    @IBOutlet weak var carouselViewUI: UIView!
    @IBOutlet weak var carousel: UICollectionView!
    
    @IBOutlet weak var ImageScrolling: UIImageView!
    
    @IBOutlet weak var menuButton:UIBarButtonItem!

    @IBOutlet weak var museumNameLabel: UILabel!
   
    @IBOutlet weak var arouselBottomConstraint: NSLayoutConstraint!
    @IBOutlet var streetLabel: UILabel!
    
    @IBOutlet var cityStateZipLabel: UILabel!
    let regionRadius: CLLocationDistance = 1000
    @IBOutlet var countryLabel: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet var musemImageViewButton: UIButton!
    
    @IBOutlet var logoutButton: UIBarButtonItem!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet var LogOutButton: FBSDKLoginButton!
    
    @IBOutlet var mapDetailSubView: UIView!
    
    typealias DownloadComplete = () -> ()
   
    var number=1
    var downloadedMuseums:[Museum] = [Museum]()
    var locationManager: CLLocationManager = CLLocationManager()
    var userLocation:CLLocation?
    var museumpagebannerURL: String = "https://s3.amazonaws.com/deframe-musuem-gallery/musuem-1/banner/mfa-banner.jpg"
    var museumpageNameLabel: String?
    var museumpagestreetLabel: String?
    var museumpageCityStateZipLabel: String?
    var museumpageCountryLabel: String?
    var rev: SWRevealViewController?
    var museumId: String = "1"
    var museumPagelogoURL: String = "https://s3.amazonaws.com/deframe-musuem-gallery/musuem-1/logo/MFA.png"
    var locManager: CLLocationManager!
    var isAnyMuseumSelected: Bool = false
    let runkeeperSwitch2 = DGRunkeeperSwitch()
  
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
    func setGradientBarWithIndexPath(indexPath: IndexPath, onBar: UINavigationBar) {
        TMGradientNavigationBar().setGradientColorOnNavigationBar(bar: onBar, direction: gradientDirection, typeName: colorNames[indexPath.row])
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
     
   
        carousel.prefetchDataSource = self
         self.tabBarController?.delegate = self
      
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
     // carouselViewUI.dropShadow()
    //  carouselViewUI.layer.cornerRadius = 5.0
       
        
        locManager = CLLocationManager()
        locManager.delegate = self
        

        map.showsUserLocation = true

  

    }
    
    @IBOutlet weak var carouselUIView: UIView!
   
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
                                    self.map.addAnnotations(allMuseums)
                                    //self.addMuseumList(self.allMuseums)
                               //     let navController = self.tabBarController?.viewControllers![2] as! UINavigationController
                                 //   let vc = navController.topViewController as! ListTableViewController
                                    
                                    
                                    
                                   // vc.museum = allMuseums
                                    self.carousel.reloadItems(at: [forIndex])
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
    
   override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
    TMGradientNavigationBar().setInitialBarGradientColor(direction: .horizontal, startColor: UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0), endColor: UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0))
    setGradientBarWithIndexPath(indexPath: lastSelectedIndexPath, onBar: (navigationController?.navigationBar)!)
    }
    
    @IBAction func switchValueDidChange(sender: DGRunkeeperSwitch!) {
        print("valueChanged: \(sender.selectedIndex)")
    }
    var delegate:AddItemProtocol?

    var saveUser: [NSManagedObject] = []
 
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .default
  
      guard let appDelegate =
       UIApplication.shared.delegate as? AppDelegate else {
          return
      }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Entity")
    
        //3
        do {
            saveUser = try managedContext.fetch(fetchRequest)
            for user in saveUser{
               Constants.userName = (user.value(forKeyPath: "firstName") as? String)!
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    
        self.navigationController?.isNavigationBarHidden = true
       
   }
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        askForLocationAuthorization()
        
        if(CLLocationManager.authorizationStatus() == .denied ){
            locationManager.requestWhenInUseAuthorization()
        }
}
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // carousel.deviceRotated()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            self.performSegue(withIdentifier: "museumToFloorSegue", sender: self)
            // self.prepare(for: <#T##UIStoryboardSegue#>, sender: <#T##Any?#>)
            //Here you can initiate your new ViewController
            
        }
    }
    
    let transition = BubbleTransition()
    @IBOutlet weak var actionListMuseum: UIBarButtonItem!
    
    @IBOutlet weak var museumButtonDetails: UIButton!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "mapToMuseumSegue"{
            
            let navVC = segue.destination as? UINavigationController
            let cell = sender as! UICollectionViewCell
            let indexPath = carousel.indexPath(for: cell)
            
             //let  museumViewController = segue.destination as! MuseumViewController
            let museumViewController = navVC?.viewControllers.first as! MuseumViewController
            
       
                museumViewController.museumbannerURL = loadedmusuems![(indexPath?.row)!].bannerURL
                    //loadedmusuems[indexPath.row]
            museumViewController.museumStreetLabel = loadedmusuems![(indexPath?.row)!].street!
                
            museumViewController.museumCityStateZipLabel = loadedmusuems![(indexPath?.row)!].zip!
                museumViewController.museumCountryLabel = loadedmusuems![(indexPath?.row)!].country
                
            museumViewController.museumPageMuseumId = loadedmusuems![(indexPath?.row)!].id
                museumViewController.museumLabel = loadedmusuems![(indexPath?.row)!].name
                museumViewController.logoURL =  loadedmusuems![(indexPath?.row)!].logoURL
                
                print("using segue")

        }
        
        
        if(segue.identifier == "ListMuseums"){
            let museumListViewController = segue.destination as! ListTableViewController
            museumListViewController.museum=allMuseums
        }

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
    
  
}
