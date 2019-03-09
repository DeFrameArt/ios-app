//
//  LoginViewController.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 9/2/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//


import Foundation
import FacebookLogin
import FBSDKLoginKit
import SwiftyJSON

import CoreData
class LoginViewController: UIViewController{
   
    @IBAction func guestLogin(_ sender: Any) {
        let name="Guest"
        let url="user_icon"
    // saveItem(name, url)
    }
    var saveUser: [NSManagedObject] = []
    @IBAction func manualLoginAction(_ sender: Any) {
        startDownloadingUsers()
    }
    
    func saveItem(_ name: String,_ url:String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Entity",
                                       in: managedContext)!
        
        let user = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        user.setValue(name, forKeyPath: "firstName")
        user.setValue(url, forKeyPath: "urlPic")
        // 4
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        for one in saveUser{
            print(one.value(forKey: "firstName"))
            print(one.value(forKey: "urlPic"))
        }
        // 4
        defaults.set(true, forKey: "isUserSignedIn")
        defaults.synchronize()
        
        NotificationCenter.default.post(name:Notification.Name(rawValue:"kUserSignedInNotification"),
                                        object: nil)
    }
  //  @IBOutlet var loginButton: FBSDKLoginButton!
    var gradientLayer: CAGradientLayer!
    
    var rev: SWRevealViewController?
    var defaults:UserDefaults = UserDefaults.standard
    //var loginButton = FBSDKLoginButton()
    @IBOutlet weak var userNameText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        
        if revealViewController() != nil {
            //view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            navigationController?.navigationBar.barTintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
        }

        navigationController?.navigationBar.barTintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
        
        //loginButton.delegate = self
        //loginButton.readPermissions = ["public_profile","email","user_friends"]
        
        
        let myColor = UIColor.white
        userNameText.layer.borderColor = myColor.cgColor
        passwordText.layer.borderColor = myColor.cgColor
        
        userNameText.layer.borderWidth = 1
        passwordText.layer.borderWidth = 1
        userNameText.layer.cornerRadius = 5.0
        passwordText.layer.cornerRadius = 5.0
        
     /*   let modelName = UIDevice.current.modelName
        if(modelName=="iPhone 5s"){
            let line2 = CAShapeLayer()
            let line = CAShapeLayer()
            let screenSize = UIScreen.main.bounds
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: 10, y: (screenSize.height*0.5)))
            linePath.addLine(to: CGPoint(x:screenSize.width*0.47, y: screenSize.height*0.5))
            line.path = linePath.cgPath
            line.strokeColor = UIColor.white.cgColor
            self.view.layer.addSublayer(line)
            
            let linePath2 = UIBezierPath()
            linePath2.move(to: CGPoint(x:screenSize.width*0.53, y: (screenSize.height*0.5)))
            linePath2.addLine(to: CGPoint(x:screenSize.width-10, y: screenSize.height*0.5))
            line2.path = linePath2.cgPath
            line2.strokeColor = UIColor.white.cgColor
            self.view.layer.addSublayer(line2)
            
            
            let label = UILabel(frame: CGRect(x: screenSize.width*0.52, y: screenSize.height*0.5, width: 30, height: 21))
            label.center = CGPoint(x:screenSize.width*0.52, y: screenSize.height*0.5)
            label.textAlignment = .left
            label.text = "or"
            label.textColor=UIColor.white
            self.view.addSubview(label)
        }
        else{
            let line = CAShapeLayer()
            let screenSize = UIScreen.main.bounds
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: 10, y: (screenSize.height*0.45)))
            linePath.addLine(to: CGPoint(x:screenSize.width*0.44, y: screenSize.height*0.45))
            line.path = linePath.cgPath
            line.strokeColor = UIColor.white.cgColor
            self.view.layer.addSublayer(line)
            
            let line2 = CAShapeLayer()
            
            let linePath2 = UIBezierPath()
            linePath2.move(to: CGPoint(x:screenSize.width*0.53, y: (screenSize.height*0.45)))
            linePath2.addLine(to: CGPoint(x:screenSize.width-10, y: screenSize.height*0.45))
            line2.path = linePath2.cgPath
            line2.strokeColor = UIColor.white.cgColor
            self.view.layer.addSublayer(line2)
            
            
            let label = UILabel(frame: CGRect(x: screenSize.width*0.50, y: screenSize.height*0.45, width: 40, height: 21))
            label.center = CGPoint(x:screenSize.width*0.50, y: screenSize.height*0.45)
            label.textAlignment = .left
            label.text = "OR"
            label.textColor=UIColor.white
            self.view.addSubview(label)
        }*/
        navigationController?.navigationBar.barTintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
        
      //  loginButton.delegate = self
       // loginButton.readPermissions = ["public_profile","email","user_friends"]
        
        view.backgroundColor=UIColor(red: 253/255, green: 158/255, blue: 50/255, alpha: 1)
        // Do any additional setup after loading the view.
        userNameText.setborder()
        passwordText.setborder()
        self.addToolBar(textField: userNameText)
        self.addToolBar(textField: passwordText)
 }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
         createGradientLayer()
        // When relaunching the screen, allow user to sign without showing facebook login page
        if(FBSDKAccessToken.current() != nil) {
            let deviceScale = Int(UIScreen.main.scale)
            let width = 100 //20 * deviceScale
            let height = 100 //20 * deviceScale
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, relationship_status, picture.width(\(width)).height(\(height))"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let fbDetails = result as! NSDictionary
                    Constants.FbData.dic = fbDetails
                    print(Constants.FbData.dic)
                }
            })
            

        }
        else{
          print("User not logged In")
        }
        
         self.navigationController?.isNavigationBarHidden = true
   }
    
   override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    
}
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
  

    func saveItem(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //**Note:** Here we are providing the entityName **`Entity`** that we have added in the model
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let myItem = NSManagedObject(entity: entity!, insertInto: context)
        if(FBSDKAccessToken.current() != nil) {
            let deviceScale = Int(UIScreen.main.scale)
            let width = 100 //20 * deviceScale
            let height = 100 //20 * deviceScale
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, relationship_status, picture.width(\(width)).height(\(height))"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let fbDetails = result as! NSDictionary
                    self.defaults.set(fbDetails, forKey:"fbData")
                    Constants.FbData.dic = fbDetails
                    print(Constants.FbData.dic)
                }
            })
            //self.performSegue(withIdentifier: "LoginToMapSegue", sender: self)
            
        }
        else{
            print("User not logged In")
        }

        var firstNameLbl = Constants.FbData.dic["first_name"] as? String
        let temp = Constants.FbData.dic["picture"] as! NSDictionary
        let profile = temp["data"] as! NSDictionary
        let url = profile["url"] as! String
        
        myItem.setValue(firstNameLbl, forKey: "firstName")
        myItem.setValue(url, forKey: "firstName")
        do {
            try context.save()
        }
        catch{
            print("There was an error in saving data")
        }
        
       
        
        
    }
 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // .default
    }
    

}

extension LoginViewController{
    
    func startDownloadingUsers(){
        
        let userName=self.userNameText.text!
        let formatString=userName.replacingOccurrences(of:"@", with:"%40", options: NSString.CompareOptions.literal, range: nil)
        let parameters=["emailAddress":userNameText.text,"password":self.passwordText.text,"role":"string"] as [String : Any]
        guard let url=URL(string:"http://deframe-test-api.us-east-1.elasticbeanstalk.com:80/accounts/login")else{ return }
        var request=URLRequest(url:url)
        request.httpMethod="POST"
        guard let httpBody=try? JSONSerialization.data(withJSONObject: parameters, options: [])else{
            
            return}
        request.httpBody=httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request){
            (data,response,error) in
            if let response=response{
                print(response)
            }
            if let data=data{
                
                print(String(data: data, encoding: String.Encoding.utf8)!)
                let message=String(data: data, encoding: String.Encoding.utf8)!
                
                if (message=="\"OK\""){
                     let url11 : String = "http://deframe-test-api.us-east-1.elasticbeanstalk.com:80/users/emailaddress/" + formatString + "/"
                    self.downloadUserInfo(url11) {(array) in
                    print("in  download prediction callback ")
                        
                    
                }
                }
                else{
                    let alert = UIAlertController(title:"", message: "Please make sure that username and passwords are correct", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    OperationQueue.main.addOperation {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
               
            }
            }.resume()
        
    
        
        if(Thread.isMainThread){
            print("in Main Thread 0")}
        else{
            print(" not in Main Thread 0")
        }
        
       // downloadUserInfo(url1) {(array) in
            print("in  download prediction callback ")
        
        print("Schedule cant be called here")
   
    }
    
    
    func downloadUserInfo(_ urlStr:String,completion: @escaping (_ array:[NewUser]) -> ()) {
        
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrentt", attributes: .concurrent)
        
        if(Thread.isMainThread){
            print("in Main Thread 1")}
        else{
            print(" not in Main Thread 1")
        }
        let userName=self.userNameText.text!
        let formatString=userName.replacingOccurrences(of:"@", with:"%40", options: NSString.CompareOptions.literal, range: nil)
        concurrentQueue.async {
            
            let url1 : String = "http://deframe-test-api.us-east-1.elasticbeanstalk.com:80/users/emailaddress/" + formatString + "/"
            
            let url = URL(string: url1)
            
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
                                 OperationQueue.main.addOperation {
                                self.present(alert, animated: true, completion: nil)
                                }
                                
                            }
                            else{
                                print(json)
                                
                                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                                    
                                let userLog = parsedData["emailAddress"] as? String
                                    
                                    if(self.userNameText.text == userLog){
                                      
                                        let userFirstName = parsedData["firstName"] as? String
                                        let userLastName = parsedData["lastName"] as? String
                                        let userpassword = parsedData["password"]as? String
                                        let userpic=parsedData["profilePicture"]as? String
                                       OperationQueue.main.addOperation {
                                        guard let appDelegate =
                                            UIApplication.shared.delegate as? AppDelegate else {
                                                return
                                        }
                                        
                                        // 1
                                        let managedContext =
                                            appDelegate.persistentContainer.viewContext
                                        
                                        // 2
                                        let entity =
                                            NSEntityDescription.entity(forEntityName: "Entity",
                                                                       in: managedContext)!
                                        
                                        let user = NSManagedObject(entity: entity,
                                                                   insertInto: managedContext)
                                        
                                        // 3
                                        
                                        user.setValue(userFirstName, forKeyPath: "firstName")
                                        
                                        do {
                                            try managedContext.save()
                                            
                                        } catch let error as NSError {
                                            print("Could not save. \(error), \(error.userInfo)")
                                        }
                                        appDelegate.saveContext()
                                        
                                        // 4
                                        self.defaults.set(true, forKey: "isUserSignedIn")
                                        self.defaults.synchronize()
                                        
                                        NotificationCenter.default.post(name:Notification.Name(rawValue:"kUserSignedInNotification"),
                                                                        object: nil)
                                        
                                      
                                        }
                                        DispatchQueue.main.async(execute: {
                                            
                                            
                                            
                                            print("Moving to Main Thread")
                                            
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



extension UITextField {
    
    func setborder(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
}
public extension UIDevice {
    
    
    var modelName: String {
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

//To minimize the keyboard
extension LoginViewController: UITextFieldDelegate{
    func addToolBar(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.tintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
         let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(LoginViewController.donePressed))
        toolBar.items = [flexBarButton, doneButton]
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
        
        
        
        
        
        
    }
    func donePressed(){
        self.userNameText.endEditing(true)
        self.passwordText.endEditing(true)
    }
    
}

