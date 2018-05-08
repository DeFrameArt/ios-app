
//
//  MenuController.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 7/8/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import UIKit
import Foundation
import FacebookLogin
import FBSDKLoginKit
import CoreData

class MenuController: UITableViewController {
    
    
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var logOut: UILabel!
    var UrlPic:String!
    var defaults:UserDefaults = UserDefaults.standard
     var saveUser: [NSManagedObject] = []
   
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
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
            for one in saveUser{
                print(one.value(forKey: "firstName"))
                
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
       //self.viewTop.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:47.0)
       let modelName = UIDevice.current.modelName1
        print(modelName)
        //Constants.FbData.dic = defaults.value(forKey: "fbData") as! NSDictionary
        
        ////////////////////////////
        /* firstNameLbl.text = Constants.FbData.dic["first_name"] as? String
         let temp = Constants.FbData.dic["picture"] as! NSDictionary
         let profile = temp["data"] as! NSDictionary
         let url = profile["url"] as! String
         if let url = NSURL(string: url) {
         if let data = NSData(contentsOf: url as URL) {
         profileImg.image = UIImage(data: data as Data)
         }
         }
         */
        //////////////////////////////////////////
        //Make the profile view circular
    
        for user in saveUser{
            firstNameLbl.text=user.value(forKeyPath: "firstName") as? String
            UrlPic=user.value(forKeyPath: "urlPic") as? String
            let PicUrl=UrlPic
            if (PicUrl != nil){
            profileImg.image = UIImage(named: PicUrl!)
            }
            Constants.userName = (user.value(forKeyPath: "firstName") as? String)!
        }
        
    }
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
   
    @IBOutlet weak var imageProfileCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let line2 = CAShapeLayer()
        let line = CAShapeLayer()
        let screenSize = imageProfileCell.frame
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: (screenSize.height+45)))
    
       
        
        linePath.addLine(to: CGPoint(x:screenSize.width, y: screenSize.height+45))
        line.path = linePath.cgPath
        line.strokeColor = UIColor.white.cgColor
         line.lineWidth=2
        
        
        self.view.layer.addSublayer(line)
        
      
        
       
        
        profileImg.layer.cornerRadius = (profileImg.frame.size.height/2);
        profileImg.layer.masksToBounds = true;
        profileImg.layer.borderWidth = 2;
       profileImg.layer.backgroundColor = UIColor.white.cgColor
      
        
       profileImg.layer.borderColor = (UIColor(red: 193/255, green: 77/255, blue: 121/255, alpha: 1)).cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))

       logOut.addGestureRecognizer(tapGesture)
       logOut.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        
    
        defaults.set(false, forKey: "isUserSignedIn")
    NotificationCenter.default.post(name:Notification.Name(rawValue:"kUserSignedOutNotification"),object: nil)
        self.performSegue(withIdentifier: "MenuToLoginSegue", sender: self)
deleteRecords()
    }
    
    func deleteRecords() -> Void {
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        
        let result = try? moc.fetch(fetchRequest)
        let resultData = result as! [Entity]
        
        for object in resultData {
            print(object.value(forKey:"firstName"))
            moc.delete(object)
        }
        
        do {
            try moc.save()
            profileImg.image = UIImage(named:"user_icon")
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    // MARK: Get Context
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
 
}


public extension UIDevice {
    
    
    var modelName1: String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            let DEVICE_IS_SIMULATOR = true
        #else
            let DEVICE_IS_SIMULATOR = false
        #endif
        
        var machineString : String = ""
        
        if DEVICE_IS_SIMULATOR == true
        {
            
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineString = dir
            }
        }
        else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            machineString = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        }
        switch machineString {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        default:                                        return machineString
        }
    }
}
