//
//  ArtViewController.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 8/14/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import Foundation
import SDWebImage
import SwiftyJSON
import MaterialComponents.MaterialTypography
class ArtViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate{
    

   // @IBAction func tapMainImage(_ sender: Any) {
     //   self.performSegue(withIdentifier: "imageView", sender: self)
   // }
   
    @IBOutlet var galleryCarouselView: UIScrollView!
    
    @IBOutlet var artViewPageController: UIPageControl!
    
    @IBOutlet var artImageView: UIImageView!
    
    @IBOutlet var artCollectionView: UICollectionView!
    
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet var headingLabel: UILabel!
    
    
    
    let car1 = ["image":"Logo_update"]
    let car2 = ["image":"carous"]
    let array: [String] = ["Logo_update","carous"]
    var imageURLsArray = [String]()
    var artPageMuseumId: String?
    var carArray = [Dictionary<String,String>]()
    var artPageImageURLsArray = [String]()
    var artPageHeadingsArray = [String]()
    var artPageDescriptionArray = [String]()
     var artPageAuthorArray = [String]()
    var artPageFeatureType: String?
    var artPageYear = [String]()
    var allArts:[ArtView] = [ArtView]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent

        self.descriptionTextView.font = MDCTypography.captionFont()
        self.descriptionTextView.alpha = MDCTypography.captionFontOpacity()
        self.descriptionTextView.sizeThatFits(CGSize(width: self.descriptionTextView.frame.size.width, height:  self.descriptionTextView.frame.size.height))
        self.headingLabel.font = MDCTypography.titleFont()
        self.headingLabel.alpha = MDCTypography.titleFontOpacity()
        
   //   self.descriptionTextView.sizeToFit()

        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
     //   self.headingLabel.sizeToFit()
        
        self.authorLabel.font = MDCTypography.subheadFont()
        self.authorLabel.alpha = MDCTypography.subheadFontOpacity()
        
        
      //  self.authorLabel.sizeToFit()
        
        self.yearLabel.font = MDCTypography.subheadFont()
        self.yearLabel.alpha = MDCTypography.subheadFontOpacity()
        
       
        
      //  self.yearLabel.sizeToFit()
        
        
        self.startDownloadingArtImagesData()
        
        
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(true)
     UIApplication.shared.statusBarStyle = .lightContent
        artCollectionView.layoutIfNeeded()
        artCollectionView.isScrollEnabled = true
        artCollectionView.contentSize = CGSize(width: self.view.frame.width, height: artCollectionView.frame.size.height)
    }
    
    
    
    func loadCarouselImages(){
        
        for (index,carousel) in carArray.enumerated() {
            
            if let carouselImages = Bundle.main.loadNibNamed("CarouselView", owner: self, options: nil)?.first as? CarouselView {
                
                carouselImages.carouselView.image = UIImage(named:carousel["image"]!)
                
                galleryCarouselView.addSubview(carouselImages)
                carouselImages.frame.size.width = self.view.bounds.size.width
                carouselImages.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
            
            
        }
        
        
        
    }
    

    @IBAction func viewImageBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "imageView", sender: self)
    }
    
    override func didReceiveMemoryWarning(){
        
        super.didReceiveMemoryWarning()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artPageImageURLsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: artCollectionView.frame.size.width/3 - 1, height: artCollectionView.frame.size.width/3 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artCollectionViewCell", for: indexPath) as! artCollectionViewCell
        let artImageView = cell.viewWithTag(1) as! UIImageView
        
        print(artPageImageURLsArray[indexPath.row])
        //cell.galleryHeadingLabel.text = self.artPageHeadingsArray[indexPath.row]
        
        //cell.galleryHeadingLabel.font = MDCTypography.body1Font()
       // cell.galleryHeadingLabel.alpha = MDCTypography.titleFontOpacity()
        
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
     //  cell.galleryHeadingLabel.sizeToFit()
       // cell.galleryHeadingLabel.sizeThatFits(CGSize(width: self.galleryHeadingLabel.frame.size.width, height:  self.galleryHeadingLabel.frame.size.height))
        // cell.galleryHeadingLabel.adjustsFontSizeToFitWidth = true
        artImageView.sd_setImage(with: URL(string: artPageImageURLsArray[indexPath.row]))
        
        
        return cell
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            
          
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artCollectionViewCell", for: indexPath) as! artCollectionViewCell
        
        self.artImageView.sd_setImage(with: URL(string: self.artPageImageURLsArray[indexPath.row]))
        
        self.descriptionTextView.text = self.artPageDescriptionArray[indexPath.row]
        
        self.descriptionTextView.font = MDCTypography.captionFont()
        self.descriptionTextView.alpha = MDCTypography.captionFontOpacity()
         self.descriptionTextView.sizeThatFits(CGSize(width: self.descriptionTextView.frame.size.width, height:  self.descriptionTextView.frame.size.height))
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
       // self.descriptionTextView.sizeToFit()
        
        self.headingLabel.font = MDCTypography.titleFont()
        self.headingLabel.alpha = MDCTypography.titleFontOpacity()
        
        self.headingLabel.text = self.artPageHeadingsArray[indexPath.row]
        
      
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
    //    self.headingLabel.sizeToFit()
        
        self.authorLabel.font = MDCTypography.subheadFont()
        self.authorLabel.alpha = MDCTypography.subheadFontOpacity()

        self.authorLabel.text=self.artPageAuthorArray[indexPath.row]
        
       
      //   self.authorLabel.sizeToFit()
        
        self.yearLabel.font = MDCTypography.subheadFont()
        self.yearLabel.alpha = MDCTypography.subheadFontOpacity()
        
        self.yearLabel.text=self.artPageYear[indexPath.row]
    
       // self.yearLabel.sizeToFit()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "imageView"){
           
             let artViewController = segue.destination as! ImageViewController
            print(artImageView.image)
            if artImageView.image != nil {
               print("Image Good")
            }
            else{
                print("null")
            }
            artViewController.newImage=artImageView.image
            
           // print("using segue")
        }
        
        
        
        
    }




}

extension ArtViewController{


    func startDownloadingArtImagesData(){
   
//        self.artPageMuseumId = UserDefaults.standard.value(forKey: "selected_museumId") as! String
        print(self.artPageMuseumId)
        let url : String = "http://deframe-test-api.us-east-1.elasticbeanstalk.com/museums/"+self.artPageMuseumId!+"/gallery"
        print("in  start download prediction callback ")
        
        if(Thread.isMainThread){
            print("in Main Thread 0")}
        else{
            print(" not in Main Thread 0")  
        }
        
        downloadArtImageData(url) { (array) in
//            
//            print("in  download prediction callback ")
//            //        self.downloadedMuseums = array
//            // self.tableView.reloadData()
//            
            
        }
        print("Schedule cant be called here")
        
        
        
        
    }
    
    
    
    
    func downloadArtImageData(_ urlStr:String, completion: @escaping (_ array:[ArtView]) -> ()) {
        
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrentt", attributes: .concurrent)
        
        if(Thread.isMainThread){
            print("in Main Thread 1")}
        else{
            print(" not in Main Thread 1")
        }
        
        concurrentQueue.async {
            
            //  var arrayPredictions:[Museum] = [Museum]()
            let url = URL(string: urlStr)
            
            if(Thread.isMainThread){
                print("in Main Thread 2")}
            else{
                print(" not in Main Thread 2")
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
                                print(json)
                                
                                for artImageData in (json?.arrayValue)! {
                                    
                                    let featureType = artImageData["featuretype"].stringValue
                                    
                                    if(self.artPageFeatureType == featureType){
                                        
                                        let heading = artImageData["name"].stringValue
                                        let featureImageURL = artImageData["url"].stringValue
                                        let description = artImageData["description"].stringValue
                                        let author = artImageData["artist"].stringValue
                                        let year = artImageData["year"].stringValue
                                            if(Thread.isMultiThreaded()){
                                                print("in Multi-Thread")
                                            }
                                    
                                    
                                        self.artPageImageURLsArray.append(featureImageURL)
                                        self.artPageHeadingsArray.append(heading)
                                        self.artPageDescriptionArray.append(description)
                                        self.artPageAuthorArray.append(author)
                                        self.artPageYear.append(year)
                                        let newArt = ArtView(imageURLsArray: self.artPageImageURLsArray, headingsArray: self.artPageImageURLsArray, descriptionArray: self.artPageDescriptionArray, author:self.artPageAuthorArray, year:self.artPageYear)
                                        
                                        self.allArts.append(newArt)
                                        
                                        DispatchQueue.main.async(execute: {
                                            
                                            completion(self.allArts)
                                            
                                            self.artImageView.sd_setImage(with: URL(string: self.artPageImageURLsArray[0]))
                                            
                                            self.descriptionTextView.text = self.artPageDescriptionArray[0]
                                            self.headingLabel.text = self.artPageHeadingsArray[0]
                                            self.authorLabel.text=self.artPageAuthorArray[0]
                                            self.yearLabel.text=self.artPageYear[0]
                                            self.artCollectionView.reloadData()
                                            
                                            print("Moving to Main Thread")
                                            
                                        })
                                    
                                   }
                                
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
