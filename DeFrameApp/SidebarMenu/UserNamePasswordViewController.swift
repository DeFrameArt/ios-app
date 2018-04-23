//
//  UserNamePasswordViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 2/2/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData
class UserNamePasswordViewController: UIViewController {
    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    var defaults:UserDefaults = UserDefaults.standard
    @IBAction func registerAction(_ sender: Any) {
        firstname=firstNameText.text
        lastName=lastNameText.text
        password=passwordText.text
        var email1=email
        submitAction()
    }
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    var email:String!
    var firstname:String!
    var lastName:String!
    @IBOutlet weak var NumberPassword: UILabel!
    @IBOutlet weak var SpecialCharacter: UILabel!
    @IBOutlet weak var LowerUpperCase: UILabel!
    @IBOutlet weak var charactersPassword: UILabel!
    var password:String!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        lastNameText.setborder()
        confirmPasswordText.setborder()
        passwordText.setborder()
        firstNameText.setborder()
        // Do any additional setup after loading the view.
        self.addToolBar(textField: firstNameText)
        self.addToolBar(textField: lastNameText)
        self.addToolBar(textField: passwordText)
        self.addToolBar(textField: confirmPasswordText)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        createGradientLayer()
        navigationController?.navigationBar.tintColor = .white
    }
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    @IBOutlet weak var viewCheck: UIView!
    
    @IBAction func cancelBtn(_ sender: Any) {
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        UIApplication.shared.keyWindow?.rootViewController = loginViewController
    }
    
    
    @IBAction func passwordCheck(_ sender: Any) {
        if(self.passwordText.text?.isValidPasswordNumber())!{
            NumberPassword.textColor=UIColor.green
            
        }
        if(self.passwordText.text?.isValidPasswordSpecialCharacter())!{
            SpecialCharacter.textColor=UIColor.green
        }
        if(self.passwordText.text?.isValidPasswordCapital())!{
            LowerUpperCase.textColor=UIColor.green
        }
        if(self.passwordText.text?.isValidPasswordLower())!{
            charactersPassword.textColor=UIColor.green
        }
        
        if(!((self.passwordText.text?.isValidPasswordNumber())!)){
            NumberPassword.textColor=UIColor.white
            
        }
        if(!(self.passwordText.text?.isValidPasswordSpecialCharacter())!){
            SpecialCharacter.textColor=UIColor.white
        }
        if(!(self.passwordText.text?.isValidPasswordCapital())!){
            LowerUpperCase.textColor=UIColor.white
        }
        if(!(self.passwordText.text?.isValidPasswordLower())!){
            
            charactersPassword.textColor=UIColor.white
        }
        
        
    }
}

extension UserNamePasswordViewController{
    func submitAction() {
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
        
        concurrentQueue.async {
            
            if((self.passwordText.text!==self.confirmPasswordText.text!) && (self.firstNameText.text != "") && (self.lastNameText.text! != "") && (self.passwordText.text != "") || (self.confirmPasswordText.text != "")){
                
                if (self.passwordText.text!==self.confirmPasswordText.text!) && (self.passwordText.text?.isValidPassword())!{
                    
                    let parameters=["emailAddress":self.email,"firstName":self.firstname, "lastName": self.lastName,"password":self.password,"role":"Visitor"] as [String : Any]
                    guard let url=URL(string:"http://deframe-test-api.us-east-1.elasticbeanstalk.com/users/add")else{ return }
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
                            do{
                                let json=try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject]
                                let alertController = UIAlertController(title:"", message: "Account is created", preferredStyle: UIAlertControllerStyle.alert)
                                let error = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) { action in
                                    
                                    
                                    guard let appDelegate =
                                        UIApplication.shared.delegate as? AppDelegate else {
                                            return
                                    }
                                    let managedContext =
                                        appDelegate.persistentContainer.viewContext
                                    
                                    // 2
                                    let entity =
                                        NSEntityDescription.entity(forEntityName:"Entity",
                                                                   in: managedContext)!
                                    let user = NSManagedObject(entity: entity,
                                                               insertInto: managedContext)
                                    user.setValue(self.firstname, forKeyPath: "firstName")
                                    
                                    do {
                                        try managedContext.save()
                                        
                                    } catch let error as NSError {
                                        print("Could not save. \(error), \(error.userInfo)")
                                    }
                                    appDelegate.saveContext()
                                    
                                    self.defaults.set(true, forKey: "isUserSignedIn")
                                    self.defaults.synchronize()
                                    
                                    NotificationCenter.default.post(name:Notification.Name(rawValue:"kUserSignedInNotification"),
                                                                    object: nil)
                                    
                                }
                                alertController.addAction(error)
                                OperationQueue.main.addOperation {
                                    self.present(alertController, animated: true, completion: nil)
                                }
                            }
                            catch{
                                print(error)
                            }
                        }
                        }.resume()
                    
                    
                }
                else{
                    let alertController = UIAlertController(title: "Attention", message: "Password Requirements does match", preferredStyle: UIAlertControllerStyle.alert)
                    let error = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) { action in
                        
                        
                    }
                    alertController.addAction(error)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
                
            else
            {
                let alertController = UIAlertController(title: "Attention", message: "Please enter your email", preferredStyle: UIAlertControllerStyle.alert)
                let error = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) { action in
                    
                    
                }
                alertController.addAction(error)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
            
            
        }
        
    }
    
}

extension UserNamePasswordViewController: UITextFieldDelegate{
    func addToolBar(textField: UITextField){
        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.tintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: "donePressed")
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    func donePressed(){
        self.firstNameText.endEditing(true)
        self.lastNameText.endEditing(true)
        self.passwordText.endEditing(true)
        self.confirmPasswordText.endEditing(true)
    }
    
}



