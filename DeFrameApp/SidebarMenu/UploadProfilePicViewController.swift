//
//  UploadProfilePicViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 2/2/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit
import SwiftyJSON
class UploadProfilePicViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //@IBOutlet var imageView: UIImageView!
    @IBOutlet weak var Photo: UIImageView!
    let imagePicker = UIImagePickerController()
    var gradientLayer: CAGradientLayer!
    var email:String?
    var FirstName:String?
    var LastName:String?
    var Password:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func UploadAction(_ sender: Any) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            Photo.contentMode = .scaleAspectFit
            Photo.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func CreateFinishAction(_ sender: Any) {
        
        submitAction()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        createGradientLayer()
    }
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
extension UploadProfilePicViewController{
    func submitAction() {
        let parameters=["emailAddress":self.email,"firstName": self.FirstName, "lastName": self.LastName,"password":self.Password,"role":"visitor"]
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
                    print(json)
                }
                catch{
                    print(error)
                }
            }
            }.resume()
        
    }
    
    
}
extension JSON{
    mutating func appendIfArray(json:JSON){
        if var arr = self.array{
            arr.append(json)
            self = JSON(arr);
        }
    }
    
    mutating func appendIfDictionary(key:String,json:JSON){
        if var dict = self.dictionary{
            dict[key] = json;
            self = JSON(dict);
        }
    }
}



