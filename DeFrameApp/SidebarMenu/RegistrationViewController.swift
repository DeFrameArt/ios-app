//
//  RegistrationViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 2/2/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit
class RegistrationViewController: UIViewController, UIBarPositioningDelegate {
    var gradientLayer: CAGradientLayer!
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        emailText.setborder2()
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.tintColor = .white
        // Do any additional setup after loading the view.
        self.addToolBar(textField: emailText)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        createGradientLayer()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "NamePasswordSegue"){
            
            let UserNPViewController = segue.destination as! UserNamePasswordViewController
            if emailText.text==""{
                let alertController = UIAlertController(title: "Attantion", message: "Please enter your email", preferredStyle: UIAlertControllerStyle.alert)
                let error = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) { action in
                    
                    
                }
                alertController.addAction(error)
                
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                
                if (emailText.text?.isEmail)! {
                    UserNPViewController.email=emailText.text
                    print(emailText)
                }
                else{
                    let alertController = UIAlertController(title: "Attantion", message: "Please enter your email", preferredStyle: UIAlertControllerStyle.alert)
                    let error = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) { action in
                        
                        
                    }
                    alertController.addAction(error)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
            
            
            
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        let presentingViewController: UIViewController! = self.presentingViewController
        
        self.dismiss(animated: false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismiss(animated: false, completion: nil)
        }
    }
    
    
    
    
}

extension UITextField {
    
    func setborder2(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
}
extension String {
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    public func isValidPasswordNumber() -> Bool {
        let passwordRegex = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    public func isValidPasswordSpecialCharacter() -> Bool {
        let passwordRegex = ".*[!&^%$#@()/_*+-]+.*"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    public func isValidPasswordCapital() -> Bool {
        let passwordRegex = ".*[A-Z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    public func isValidPasswordLower() -> Bool {
        let passwordRegex = ".*.{8,}.*"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    public var length: Int {
        return self.characters.count
    }
}

extension RegistrationViewController: UITextFieldDelegate{
    func addToolBar(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.tintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(RegistrationViewController.donePressed))
        toolBar.items = [flexBarButton, doneButton]
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    func donePressed(){
        self.emailText.endEditing(true)
    }
    
}
