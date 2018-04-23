//
//  NewUser.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 2/5/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit

class NewUser: NSObject {
    var FirstName:String?
    var Photo:String?
    
    init(Email:String, FirstName:String, LastName:String, Password:String, Photo:String){
        
        self.FirstName=FirstName;
        
        self.Photo=Photo;
    }
    
    
}
