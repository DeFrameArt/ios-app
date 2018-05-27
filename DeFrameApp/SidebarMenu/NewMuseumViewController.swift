//
//  NewMuseumViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 1/25/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import Foundation
import SDWebImage
import SwiftyJSON

class NewMuseumViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
   
    @IBOutlet var carouselViewPageControl: UIPageControl!
    
    @IBOutlet var collectionViewTapGesture: UIImageView!
    
    let car1 = ["image":"Logo_update"]
    let car2 = ["image":"carous"]
    let array: [String] = ["Logo_update","carous"]
    var featureImageURLsArray = [String]()
    var headingsArray = [String]()
    var museumbannerURL: String?
    var museumLabel: String?
    var museumStreetLabel="Error"
    var museumCityStateZipLabel="Error"
    var museumCountryLabel: String?
    var carArray = [Dictionary<String,String>]()
    var museumPageMuseumId: String?
    var featureType: String?
    var logoURL: String?
   /* @IBOutlet var galleryCollectionView: UICollectionView!*/
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))
        let tapGestureBotButton = UITapGestureRecognizer(target: self, action: #selector(self.botButtonTapped(gesture:)))
        
       
        
        
        
        self.startDownloadingImagesData()
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
    
    func botButtonTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("bot Tapped")
            self.performSegue(withIdentifier: "museumToChatBotSegue", sender: self)
        }
    }
    
    
    override func didReceiveMemoryWarning(){
        
        super.didReceiveMemoryWarning()
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featureImageURLsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 - 1, height: collectionView.frame.size.width/3 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artCollectionViewCell", for: indexPath) as! artCollectionViewCell
        cell.artCollectionImageView.sd_setImage(with: URL(string: featureImageURLsArray[indexPath.row]))
        
        print(featureImageURLsArray[indexPath.row])
       
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "artHeaderCollectionReusableView", for: indexPath) as! artHeaderCollectionReusableView
        
        return headerView
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplayCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        print("willDisplaySupplementaryView")
    }
    
    
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "museumToArtSegue"){
            
            let cell = sender as! UICollectionViewCell
            let indexPath = galleryCollectionView.indexPath(for: cell)
            
            let artViewController = segue.destination as! ArtViewController
            print(self.headingsArray[(indexPath?.row)!])
            print(self.museumPageMuseumId)
            artViewController.artPageFeatureType = self.headingsArray[(indexPath?.row)!]
            artViewController.artPageMuseumId = self.museumPageMuseumId
            
            
          
            print("using segue")
        }
        
        if(segue.identifier == "museumToFloorSegue"){
            
          
            let floorViewController = segue.destination as! FloorPlanViewController
            //print(self.headingsArray[(indexPath?.row)!])
            print(self.museumPageMuseumId)
            
            floorViewController.floorPageMuseumId = self.museumPageMuseumId
          
            
            print("using segue")
        }
        
        
    }
    
    
}


extension NewMuseumViewController{
    
    func startDownloadingImagesData(){
        
        
        var url1 : String = "http://deframe-test-api.us-east-1.elasticbeanstalk.com/museums/"+self.museumPageMuseumId!+"/featuredimages"
        
        print("in  start download prediction callback ")
        
        if(Thread.isMainThread){
            print("in Main Thread 0")}
        else{
            print(" not in Main Thread 0")
        }
        
        downloadImageData(url1) { (array) in
            print("in  download prediction callback ")
          
            
        }
        print("Schedule cant be called here")
        
        
        
        
    }
    
    
    
    
    func downloadImageData(_ urlStr:String, completion: @escaping () -> ()) {
        
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
                                
                                for imageData in (json?.arrayValue)! {
                                    
                                    let id = imageData["id"].stringValue
                                    let heading = imageData["name"].stringValue
                                    let featureImageURL = imageData["url"].stringValue
                                    //self.featureType = imageData["name"].stringValue
                                    
                                    
                                    
                                    if(Thread.isMultiThreaded()){
                                        print("in Multi-Thread")
                                    }
                                    
                                    
                                    self.featureImageURLsArray.append(featureImageURL)
                                    self.headingsArray.append(heading)
                                    
                                    DispatchQueue.main.async(execute: {
                                        self.galleryCollectionView.reloadData()
                                        print("Moving to Main Thread")
                                        if(Thread.isMainThread){
                                            print("in Main Thread 2")}
                                        else{
                                            print(" not in Main Thread 2")
                                        }
                                    })
                                    
                                }
                            }
                            
                            
                            
                        }
                            
                        catch {
                            print(error.localizedDescription)
                        }
                    } // if
                }
                
                
            }
            
            task.resume()
        }
        
        
        
        
    }
    
    
    
    
    
}

