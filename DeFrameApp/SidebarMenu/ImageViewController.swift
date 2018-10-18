//
//  ImageViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 10/17/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
  var interactor:Interactor? = nil
  //  @IBOutlet var tapPan: UIPanGestureRecognizer!
    @IBOutlet weak var imageView: UIImageView!
    var newImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = newImage
        self.view.isUserInteractionEnabled = true
        let tapGesture = UIPanGestureRecognizer(target: self, action: #selector(ImageViewController.tappanBtn(_:)))
        self.view.addGestureRecognizer(tapGesture)
    
        // Do any additional setup after loading the view.
    }

    @IBAction func dissmisBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tappanBtn(_ gestureRecognizer: UIPanGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
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
