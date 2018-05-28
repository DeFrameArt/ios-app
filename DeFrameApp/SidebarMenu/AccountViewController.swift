//
//  AccountViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 5/9/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//
import UIKit
import Foundation
import FacebookLogin
import FBSDKLoginKit
import CoreData
class AccountViewController: UIViewController {

    @IBOutlet weak var LogOutLabel: UILabel!
    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var logOut: UIView!
    @IBOutlet weak var privacyView: UIView!
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var tabSection: UIView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    var gradient: CAGradientLayer!
    var defaults:UserDefaults = UserDefaults.standard
    var saveUser: [NSManagedObject] = []
     var UrlPic:String!
    
    override func viewDidLayoutSubviews() {
        let gradient = CAGradientLayer()
        gradient.frame.size = self.viewImage.bounds.size
        //gradient.frame = view.bounds
        gradient.frame.size = self.viewImage.bounds.size
        gradient.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        
        viewImage.layer.insertSublayer(gradient, at: 0)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         UIApplication.shared.statusBarStyle = .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        UIApplication.shared.statusBarStyle = .lightContent

        viewImage.layer.shadowOpacity = 0.5
        viewImage.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        viewImage.layer.shadowRadius = 5.0
        viewImage.layer.shadowColor = UIColor.black.cgColor
        
        tabView.layer.shadowOpacity = 0.5
        tabView.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        tabView.layer.shadowRadius = 5.0
        tabView.layer.shadowColor = UIColor.lightGray.cgColor
        
        
        
        
        
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
        
        for user in saveUser{
            Name.text=user.value(forKeyPath: "firstName") as? String
            UrlPic=user.value(forKeyPath: "urlPic") as? String
            let PicUrl=UrlPic
            if (PicUrl != nil){
                imageProfile.image = UIImage(named: PicUrl!)
            }
            Constants.userName = (user.value(forKeyPath: "firstName") as? String)!
        }
       
        
        imageProfile.layer.cornerRadius = (imageProfile.frame.size.height/2);
        imageProfile.layer.masksToBounds = true;
        imageProfile.layer.borderWidth = 2;
        imageProfile.layer.backgroundColor = UIColor.white.cgColor
        
        
        imageProfile.layer.borderColor = (UIColor(red: 193/255, green: 77/255, blue: 121/255, alpha: 1)).cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))
        
       LogOutLabel.addGestureRecognizer(tapGesture)
       LogOutLabel.isUserInteractionEnabled = true
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
             imageProfile.image = UIImage(named:"user_icon")
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

   
}
extension UIView {
    
    // OUTPUT 1
    func dropShadow1(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
