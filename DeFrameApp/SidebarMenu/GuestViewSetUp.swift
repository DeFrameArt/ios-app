//
//  GuestViewSetUp.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 3/25/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import Foundation

import UIKit
import FacebookLogin
import MapKit
import CoreLocation
import FBSDKCoreKit
import CoreData
import Tamamushi
import MaterialComponents.MaterialTextFields

class GuestViewSetUp:UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var NickUserText: UITextField!
    let colorNames = [
        "SoundCloud",
        "Facebook Messenger",
        "Flickr",
        "Vine",
        "YouTube",
        "Pinky",
        "Sunrise",
        "Playing with Reds",
        "Ukraine",
        "Curiosity blue",
        "Between Night and Day",
        "Timber",
        "Passion",
        "Master Card",
        "Green and Blue",
        "Inbox",
        "Little Leaf",
        "Alihossein",
        "Endless River",
        "Kyoto",
        "Twitch"
    ]
    
    var lastSelectedIndexPath = IndexPath(row: 0, section: 0)
    var gradientDirection = Direction.vertical
    func setGradientBarWithIndexPath(indexPath: IndexPath, onBar: UINavigationBar) {
        TMGradientNavigationBar().setGradientColorOnNavigationBar(bar: onBar, direction: gradientDirection, typeName: colorNames[indexPath.row])
    }
    var listOFImages=["userPic3.png","userPic4.png","userPic8.png","userPic9.png","userPic11.png","userPic5.png","userPic7.png","userPic2.png","UserProfile.png"]
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.tintColor = .white
        
        viewPart1.layer.shadowOpacity = 0.5
        viewPart1.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        viewPart1.layer.shadowRadius = 1.0
       viewPart1.layer.shadowColor = UIColor.lightGray.cgColor
        
        viewPart2.layer.shadowOpacity = 0.5
        viewPart2.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        viewPart2.layer.shadowRadius = 1.0
        viewPart2.layer.shadowColor = UIColor.lightGray.cgColor
        
        var gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame = self.toolBarGuest.bounds
        gradient.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        self.toolBarGuest.layer.insertSublayer(gradient, at: 0)
    }
    @IBOutlet weak var toolBarGuest: UIToolbar!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
       
        self.navigationController?.isNavigationBarHidden = false
        TMGradientNavigationBar().setInitialBarGradientColor(direction: .horizontal, startColor: UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0), endColor: UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0))
        setGradientBarWithIndexPath(indexPath: lastSelectedIndexPath, onBar: (navigationController?.navigationBar)!)
       // NickUserText = MDCTextField()
        NickUserText.layer.borderColor = (UIColor(red: 193/255, green: 77/255, blue: 121/255, alpha: 1)).cgColor
       
        NickUserText.layer.borderWidth = 1
        NickUserText.layer.cornerRadius = 5.0
        self.addToolBar(textField: NickUserText)
    }
    var defaults:UserDefaults = UserDefaults.standard
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOFImages.count
    }
    @IBOutlet weak var viewPart1: UIView!
    
    @IBOutlet weak var viewPart2: UIView!
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 - 6, height: collectionView.frame.size.width/3 - 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuestCell", for: indexPath) as! GuestCell
        
        
        cell.imageUser.image=UIImage(named:listOFImages[indexPath.row])
        cell.layer.cornerRadius = cell.frame.size.width / 2
        cell.clipsToBounds = true
        cell.layer.borderWidth = 2
        cell.layer.borderColor = (UIColor(red: 193/255, green: 77/255, blue: 121/255, alpha: 1)).cgColor
        return cell
    }
    func saveText(_ textName:String){
        name=textName
        print(name)
    }
    var selectedImage:String?
    var name:String?
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let commentView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GuestViewHeader", for: indexPath) as! GuestViewHeader
        
        
        return commentView
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! GuestCell
        var imageSelected=listOFImages[indexPath.row]
        
        cell.imageUser.backgroundColor=UIColor(red: 193/255, green: 77/255, blue: 121/255, alpha: 1)
        
        selectedImage=imageSelected
        
        print(imageSelected)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! GuestCell
        
        cell.imageUser.backgroundColor=UIColor.white
        
    }
    
    @IBAction func LogInAction(_ sender: Any) {
        if (NickUserText.text!==nil || NickUserText.text!==""){
            let alert = UIAlertController(title:"", message: "Please enter your name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            OperationQueue.main.addOperation {
                self.present(alert, animated: true, completion: nil)
            }
        }
        else if (selectedImage==nil){
            let alert = UIAlertController(title:"", message: "Please choose the image", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            OperationQueue.main.addOperation {
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            saveItem(NickUserText.text!,selectedImage!)
        }
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
        
        // 4
        defaults.set(true, forKey: "isUserSignedIn")
        defaults.synchronize()
        
        NotificationCenter.default.post(name:Notification.Name(rawValue:"kUserSignedInNotification"),
                                        object: nil)
    }
}

extension GuestViewSetUp: UITextFieldDelegate{
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
        self.NickUserText.endEditing(true)
    }
}
