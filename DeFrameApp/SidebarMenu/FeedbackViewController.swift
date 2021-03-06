//
//  FeedbackViewController
//  DeFrameApp
//
//  Created by Ankur Bag on 11/11/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//



import UIKit
import Foundation
import MessageUI
import Tamamushi
class FeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var tt: UITextView!
    @IBOutlet weak var sendEmailBtn: UIButton!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent

            if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            navigationController?.navigationBar.barTintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
            
        }
        var borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tt.layer.borderWidth = 0.5
        tt.layer.borderColor = borderColor.cgColor
        tt.layer.cornerRadius = 5.0
        
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        //view.addGestureRecognizer(tap)
        //hideKeyboardWhenTappedAround()
        self.addToolBar(textview: tt)
        TMGradientNavigationBar().setInitialBarGradientColor(direction: .horizontal, startColor: UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0), endColor: UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0))
        setGradientBarWithIndexPath(indexPath: lastSelectedIndexPath, onBar: (navigationController?.navigationBar)!)
    }
    func setGradientBarWithIndexPath(indexPath: IndexPath, onBar: UINavigationBar) {
        TMGradientNavigationBar().setGradientColorOnNavigationBar(bar: onBar, direction: gradientDirection, typeName: colorNames[indexPath.row])
    }
//
//    func dismissKeyboard() {
//        view.endEditing(true)
//    }
    @IBAction func ActionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var closeAction: UIBarButtonItem!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendEmailTapped(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        let messageBody = tt
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["feedback@deframeart.com"])
        mailComposerVC.setSubject("Message from DeFrameApp: Customer Feedback")
        mailComposerVC.setMessageBody((messageBody?.text)!, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send Email.  Please check Email configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}

extension FeedbackViewController: UITextViewDelegate {
    func addToolBar(textview: UITextView){
        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: "donePressed")
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textview.delegate = self
        textview.inputAccessoryView = toolBar
    }
    func donePressed(){
        self.tt.endEditing(true)
    }
}


