//
//  ArtView.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 9/22/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import Foundation

class ArtView: NSObject {
    
    var imageURLsArray = [String]()
    var headingsArray = [String]()
    var descriptionArray = [String]()
    var author = [String]()
    var year=[String]()
    
    init(imageURLsArray: [String], headingsArray:[String], descriptionArray: [String], author: [String], year:[String]){
        
        self.imageURLsArray = imageURLsArray
        self.headingsArray = headingsArray
        self.descriptionArray = descriptionArray
        self.author=author
        self.year=year
        
    }





}
