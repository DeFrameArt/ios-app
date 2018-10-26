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
//protocol AddItemProtocol {
    //code for the requirements of this protocole
  //  func addMusuem(_ item:SelectedMuseum)
//}


protocol AddItemProtocol {
    //code for the requirements of this protocole
    func addItemtoCheckList(_ item:[Museum])
}
var allMuseums:[Museum] = [Museum]()
var downloadedMuseums:[Museum] = [Museum]()
class MapViewController: UIViewController, CLLocationManagerDelegate, UIViewControllerTransitioningDelegate,UITabBarControllerDelegate {
    // var delegate:AddItemProtocol?
    @IBOutlet weak var menuButton:UIBarButtonItem!

    @IBOutlet weak var museumNameLabel: UILabel!
   
    @IBOutlet var streetLabel: UILabel!
    
    @IBOutlet var cityStateZipLabel: UILabel!
    
    @IBOutlet var countryLabel: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet var musemImageViewButton: UIButton!
    
    @IBOutlet var logoutButton: UIBarButtonItem!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet var LogOutButton: FBSDKLoginButton!
    
    @IBOutlet var mapDetailSubView: UIView!
    
    typealias DownloadComplete = () -> ()
   // var allMuseums:[Museum] = [Museum]()
    //var downloadedMuseums:[Museum] = [Museum]()
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
         self.tabBarController?.delegate = self
       // navigationController?.navigationBar.tintColor = UIColor.white
        
      /*  TMGradientNavigationBar().setInitialBarGradientColor(direction: .horizontal, startColor: UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0), endColor: UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0))
        setGradientBarWithIndexPath(indexPath: lastSelectedIndexPath, onBar: (navigationController?.navigationBar)!)*/
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        infoView.dropShadow()
        infoView.layer.cornerRadius = 5.0
       
        
        locManager = CLLocationManager()
        locManager.delegate = self
        

        map.showsUserLocation = true

         self.museumNameLabel.font = MDCTypography.subheadFont()
       /// titleFont()
         self.museumNameLabel.alpha = MDCTypography.titleFontOpacity()
        
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
         self.museumNameLabel.sizeToFit()
        
        
        self.streetLabel.font = MDCTypography.captionFont()
        self.streetLabel.alpha = MDCTypography.body1FontOpacity()
        
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
        self.streetLabel.sizeToFit()
        
        self.cityStateZipLabel.font = MDCTypography.captionFont()
        self.cityStateZipLabel.alpha = MDCTypography.body1FontOpacity()
        
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
        self.cityStateZipLabel.sizeToFit()
        
        self.countryLabel.font = MDCTypography.captionFont()
        self.countryLabel.alpha = MDCTypography.body1FontOpacity()
        
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
        self.countryLabel.sizeToFit()
        
        self.musemImageViewButton.sd_setBackgroundImage(with: URL(string: "https://s3.amazonaws.com/deframe-musuem-gallery/musuem-1/banner/mfa-banner.jpg"), for: .normal)
        self.museumNameLabel.text = "Museum of Fine Arts"
        self.streetLabel.text = "465 Huntington Ave"
        self.cityStateZipLabel.text = "Boston MA, 02115"
       // self.countryLabel.text = "United States"
                
        self.startDownloadingMuseums()
      
    }
    
   /* override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
        let vc = self.tabBarController?.viewControllers![2] as! ListTableViewController
        vc.museum = allMuseums
    }*/
    
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func askForLocationAuthorization(){
        if(CLLocationManager.authorizationStatus() == .notDetermined){
            
            locManager.requestWhenInUseAuthorization()
        }
        
        //                setRegion()
        map.addAnnotations(downloadedMuseums)
        map.delegate = self
    }
    
    func addGeolocation()
    {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        
    }
    
 
    
    
    
    func setRegion(){
        
       print(locationManager.location?.coordinate)
        
                    let lat = locationManager.location?.coordinate.latitude
                    let lng = locationManager.location?.coordinate.longitude
        
        
                    let span:MKCoordinateSpan = MKCoordinateSpanMake(0.15, 0.15)
        
        
                    print(lat)
        
                    if(lat == nil || lng == nil){
                       let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake( 42.343778, -71.09809239999998)
                        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                        //map.setCenter((locationManager.location?.coordinate)!, animated:true)
                        map.setCenter(location, animated:true)
                        map.setRegion(region, animated: true)
                        map.regionThatFits(region)
        
                    }
                    else{
                        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, lng!)
                        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                        map.setCenter((locationManager.location?.coordinate)!, animated:true)
                        map.setRegion(region, animated: true)
                        map.regionThatFits(region)
                        print(userLocation)
        
                    }
        
        
    }
 
    
    
    func addMap() {
        
        let annotations = allMuseums.map { museum -> MKAnnotation in
            
            let museumName =  museum.name!
            
            let annotation = MKPointAnnotation()
            //annotation.title = "Next Station" + location.tripHeadsign!
            annotation.title = museumName
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: museum.lat!, longitude: museum.lon!)
            
            return annotation
        }
        //arrayannotations = annotations
        map.addAnnotations(annotations)
        
    }
    
    let transition = BubbleTransition()
    @IBOutlet weak var actionListMuseum: UIBarButtonItem!
    
    @IBOutlet weak var museumButtonDetails: UIButton!
  //  let navVC = segue.destination as? UINavigationController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "mapToMuseumSegue"{
            
        //    let navVC = segue.destination as? UINavigationController
            
            let  museumViewController = segue.destination as! MuseumViewController
            //let museumViewController = navVC?.viewControllers.first as! MuseumViewController

            if(self.isAnyMuseumSelected){
                
                
           
            museumViewController.museumbannerURL = self.museumpagebannerURL
            museumViewController.museumStreetLabel = self.museumpagestreetLabel!
            museumViewController.museumCityStateZipLabel = self.museumpageCityStateZipLabel!
            museumViewController.museumCountryLabel = self.museumpageCountryLabel!
            museumViewController.museumPageMuseumId = self.museumId
            museumViewController.museumLabel = self.museumpageNameLabel!
            museumViewController.logoURL = self.museumPagelogoURL

            print("using segue")
            
            }
            else{
                
                
                museumViewController.museumbannerURL = self.museumpagebannerURL
                museumViewController.museumStreetLabel = "465 Huntington Ave"
                museumViewController.museumCityStateZipLabel = "Boston MA, 02115"
                museumViewController.museumCountryLabel = "United States"
                museumViewController.museumPageMuseumId = "1"
                museumViewController.museumLabel = "Museum of Fine Arts"
                museumViewController.logoURL = self.museumPagelogoURL
            //   navVC!.pushViewController(museumViewController, animated: true)
              //  self.navigationController!.present(museumViewController, animated: false, completion: nil)
            }
            
          // self.navigationController?.present(museumViewController, animated:true, completion:nil)
        }
       
        
        if(segue.identifier == "ListMuseums"){
            
          //  let navVC = segue.destination as? UINavigationController
       // let  museumViewController = segue.destination as! MuseumViewController
            //let museumListViewController = navVC?.viewControllers.first as! ListTableViewController
            //let museumViewController = segue.destination as! MuseumViewController
            
            
            
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

extension MapViewController: MKMapViewDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLocation = locations.first
        //print(userLocation)
    }
    
    //@objc(locationManager:didChangeAuthorizationStatus:)
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
//        if status == .authorizedAlways || status == . authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//            map.showsUserLocation = true
//            
//        }
        
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            // If authorized when in use
//            
            setRegion()
//            map.addAnnotations(downloadedMuseums)
//            map.delegate = self

            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // If always authorized
            manager.startUpdatingLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }

        
        
    }
    
    
    
func startDownloadingMuseums(){
    
//    self.allMuseums = download {
//
//
//        print(self.allMuseums[1].name!)
//    }
    
    
    let url : String = "http://deframe-test-api.us-east-1.elasticbeanstalk.com/museums"
    print("in  start download prediction callback ")
    
    if(Thread.isMainThread){
        print("in Main Thread 0")}
    else{
        print(" not in Main Thread 0")
    }
    
    downloadMuseums(url) { (array) in
        print("in  download prediction callback ")
        
    }
    
    print("Schedule cant be called here")
    
}

    func downloadMuseums(_ urlStr:String, completion: @escaping (_ array:[Museum]) -> ()) {
        
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)

        concurrentQueue.async {

          //  var arrayPredictions:[Museum] = [Museum]()
            let url = URL(string: urlStr)
            
            if(Thread.isMainThread){
                print("in Main Thread 1")}
            else{
                print(" not in Main Thread 1")
            }
            
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                
                if error == nil {
                    
                    if let dataValid = data {
                        
                        do  {
                            
                            let json = try? JSON(data: data!)
                            

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
                                    
                                    if(Thread.isMultiThreaded()){
                                        print("in Multi-Thread")
                                    }
                                    
                                    
                                    let newMuseum = Museum(id:id, name: name, acronym:acronym, street:street, city:city, state:state, country:country, zip:zip, lat: lat, lon: lon, bannerURL: bannerURL, logoURL:logoURL )
                                    allMuseums.append(newMuseum)
                                    
                                    DispatchQueue.main.async(execute: {
                                        completion(allMuseums)
                                        self.map.addAnnotations(allMuseums)
                                        //self.addMuseumList(self.allMuseums)
                                       // let navController = self.tabBarController?.viewControllers![2] as! UINavigationController
                                       // let vc = navController.topViewController as! ListTableViewController
                                    
                                        
                                      
                                      //  vc.museum = self.allMuseums
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
            
            task.resume()
        }
    
        
        
    
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation is MKUserLocation
        {
            return nil
        }
        
        
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }
            
        else{
            annotationView?.annotation = annotation
        }
        
        
        
        
        if(annotation is Museum){
            annotationView?.image = UIImage(named: "pinMap")
            
        }
        
        return annotationView
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        
        if(view.annotation is Museum){
        
            self.isAnyMuseumSelected = true
            
            let museumAnnotation = view.annotation as! Museum
            
            //self.museumImageView.image = UIImage(named: "Logo_update")
                    //self.museumImageView.sd_setImage(with: URL(string: museumAnnotation.imageName!))
                       
            
            self.museumNameLabel.text = museumAnnotation.name
            self.musemImageViewButton.sd_setImage(with: URL(string: museumAnnotation.bannerURL!), for: .normal)
            self.streetLabel.text = museumAnnotation.street
            self.cityStateZipLabel.text = museumAnnotation.city!+" "+museumAnnotation.state!+", "+museumAnnotation.zip!
           // self.countryLabel.text = museumAnnotation.country
            self.museumId = museumAnnotation.id!
            self.museumPagelogoURL = museumAnnotation.logoURL!
            UserDefaults.standard.setValue(museumAnnotation.id, forKey: "selected_museumId")

            
            self.museumpagebannerURL = museumAnnotation.bannerURL!
            self.museumpageNameLabel = museumAnnotation.name
            self.museumpagestreetLabel = self.streetLabel.text
            self.museumpageCityStateZipLabel = self.cityStateZipLabel.text
            self.museumpageCountryLabel = self.countryLabel.text
            
            
            
        }
        
 
        
    }
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }


    
    

}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        layer.shadowRadius = 5
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
}
}
