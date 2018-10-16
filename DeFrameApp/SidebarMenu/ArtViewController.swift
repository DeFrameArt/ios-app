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
    

    @IBOutlet weak var artImageView: UIButton!
    @IBOutlet var galleryCarouselView: UIScrollView!
    
    @IBOutlet var artViewPageController: UIPageControl!
    
  //  @IBOutlet var artImageView: UIImageView!
    
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
        
    //  self.descriptionTextView.sizeToFit()

        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
      //  self.headingLabel.sizeToFit()
        
        self.authorLabel.font = MDCTypography.subheadFont()
        self.authorLabel.alpha = MDCTypography.subheadFontOpacity()
        
        
       // self.authorLabel.sizeToFit()
        
        self.yearLabel.font = MDCTypography.subheadFont()
        self.yearLabel.alpha = MDCTypography.subheadFontOpacity()
        
       
        
        self.yearLabel.sizeToFit()
        
        
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
       // let artImageView = cell.viewWithTag(1) as! UIImageView
        
        print(artPageImageURLsArray[indexPath.row])
         self.artImageView.sd_setBackgroundImage(with: URL(string:self.artPageImageURLsArray[indexPath.row]), for: .normal)
       // artImageView.sd_setImage(with: URL(string: artPageImageURLsArray[indexPath.row]))
       //  imageURL=artPageImageURLsArray[indexPath.row]
        
        return cell
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            
          
            
        }
    }
    var imageURL:String?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artCollectionViewCell", for: indexPath) as! artCollectionViewCell
        self.artImageView.sd_setBackgroundImage(with: URL(string:self.artPageImageURLsArray[indexPath.row]), for: .normal)
       // self.artImageView.imageView?.sd_setImage(with: URL(string: self.artPageImageURLsArray[indexPath.row]))
       // imageURL=indexPath.row
        self.descriptionTextView.text = self.artPageDescriptionArray[indexPath.row]
        
        self.descriptionTextView.font = MDCTypography.captionFont()
        self.descriptionTextView.alpha = MDCTypography.captionFontOpacity()
       //  self.descriptionTextView.sizeThatFits(CGSize(width: self.descriptionTextView.frame.size.width, height:  self.descriptionTextView.frame.size.height))
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
       // self.descriptionTextView.sizeToFit()
        
        self.headingLabel.font = MDCTypography.titleFont()
        self.headingLabel.alpha = MDCTypography.titleFontOpacity()
        
        self.headingLabel.text = self.artPageHeadingsArray[indexPath.row]
        
      
        // If using autolayout, the following line is unnecessary as long
        // as all constraints are valid.
       // self.headingLabel.sizeToFit()
        
        self.authorLabel.font = MDCTypography.subheadFont()
        self.authorLabel.alpha = MDCTypography.subheadFontOpacity()

        self.authorLabel.text=self.artPageAuthorArray[indexPath.row]
        
       
       //  self.authorLabel.sizeToFit()
        
        self.yearLabel.font = MDCTypography.subheadFont()
        self.yearLabel.alpha = MDCTypography.subheadFontOpacity()
        
        self.yearLabel.text=self.artPageYear[indexPath.row]
    
      //  self.yearLabel.sizeToFit()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "museumToArtSegue"){
            
            print("using segue")
        }
        if(segue.identifier == "fullImage"){
             let artViewController = segue.destination as! MuseumImageViewController
          
 
        }
        //fullImage
 
    }

}
