//
//  NewMuseumViewController+Extension.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 7/24/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage
import SwiftyJSON

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

