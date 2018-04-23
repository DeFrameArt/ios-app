//
//  FloorPlanViewController.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 9/13/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class FloorPlanViewController: UIViewController, UIScrollViewDelegate{
    
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var floorPlanCarouselView: UIScrollView!
    
    var floorPageImageURLsArray = [String]()
    var artPageHeadingsArray = [String]()
    let car1 = ["image":"Logo_update"]
    let car2 = ["image":"carous"]
    var carArray = [Dictionary<String,String>]()
    var floorPageMuseumId: String?
    var levelsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carArray = [car1, car2]
        
        self.startDownloadingFloorImagesData()
        print("self.levelsArray - ",self.levelsArray.count)
    }
    
    
    func loadCarouselImages(){
        floorPlanCarouselView.isPagingEnabled = true
        floorPlanCarouselView.frame = CGRect(x: 0, y: 0, width:view.frame.width, height: view.frame.height)
        floorPlanCarouselView.contentSize = CGSize(width:self.view.bounds.width * CGFloat(floorPageImageURLsArray.count), height:view.bounds.height)
        floorPlanCarouselView.showsHorizontalScrollIndicator = false
        
        floorPlanCarouselView.maximumZoomScale = 5.0
        floorPlanCarouselView.delegate = self
        
        if let carouselImages = Bundle.main.loadNibNamed("CarouselView", owner: self, options: nil)?.first as? CarouselView {
            carouselImages.carouselView.sd_setImage(with: URL(string: floorPageImageURLsArray[0]))
            floorPlanCarouselView.addSubview(carouselImages)
            carouselImages.frame.size.width = self.view.bounds.size.width
            carouselImages.frame.origin.x = CGFloat(0) * self.view.bounds.size.width
        }
   }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
        pageControl.numberOfPages = floorPageImageURLsArray.count
        let index =  Int(page)
        if let carouselImages = Bundle.main.loadNibNamed("CarouselView", owner: self, options: nil)?.first as? CarouselView {
            carouselImages.carouselView.sd_setImage(with: URL(string: floorPageImageURLsArray[index]))
            floorPlanCarouselView.addSubview(carouselImages)
            carouselImages.frame.size.width = self.view.bounds.size.width
            carouselImages.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
        }
        
        
    }
    
    func startDownloadingFloorImagesData(){
        
        let url : String = "http://deframe-test-api.us-east-1.elasticbeanstalk.com/museums/"+self.floorPageMuseumId!+"/floorplan"
        print("in  start download prediction callback ")
        downloadFloorImageData(url) { (array) in
        }
    }
    
    func downloadFloorImageData(_ urlStr:String, completion: @escaping () -> ()) {
        
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrentt", attributes: .concurrent)
        
        if(Thread.isMainThread){
            print("in Main Thread 1")}
        else{
            print(" not in Main Thread 1")
        }
        
        concurrentQueue.async {
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
                                for floorImageData in (json?.arrayValue)! {
                                    
                                    let level = floorImageData["name"].stringValue
                                    let imageURL = floorImageData["url"].stringValue
                                    
                                    
                                    
                                    if(Thread.isMultiThreaded()){
                                        print("in Multi-Thread")
                                    }
                                    
                                    
                                    self.floorPageImageURLsArray.append(imageURL)
                                    self.levelsArray.append(level)
                                    
                                    
                                    
                                    
                                    DispatchQueue.main.async(execute: {
                                        
                                        
                                        completion(self.loadCarouselImages())
                                        
                                        print("Moving to Main Thread")
                                        
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
    
}
