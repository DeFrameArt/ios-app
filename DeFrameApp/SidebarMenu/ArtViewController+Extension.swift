//
//  ArtViewController+Extension.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 7/24/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage
import SwiftyJSON

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
                                            self.artImageView.sd_setBackgroundImage(with: URL(string:self.artPageImageURLsArray[0]), for: .normal)
                                         //   self.artImageView.imageView?.sd_setImage(with: URL(string: self.artPageImageURLsArray[0]))
                                            
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
