//
//  WebViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 11/11/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
    UIApplication.shared.statusBarStyle = .default
        let url = URL (string: "https://www.deframeart.com/gallery/")
        let request = URLRequest(url: url!)
        webview.load(request)
       // myWebView.loadRequest(requestObj);
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
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
