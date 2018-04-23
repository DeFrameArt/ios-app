//
//  NewsTableViewController.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 7/8/17.
//  Copyright © 2017 DeFrameApp. All rights reserved.
//

import UIKit


class NewsTableViewController: UITableViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
//            revealViewController().rearViewRevealWidth = 62
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))

            revealViewController().rightViewRevealWidth = 150
            extraButton.target = revealViewController()
            extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))

            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
           
            navigationController?.navigationBar.barTintColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha:1.0)
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell

        // Configure the cell...
        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "watchkit-intro")
            cell.postTitleLabel.text = "WatchKit Introduction: Building a Simple Guess Game"
            cell.authorLabel.text = "Simon Ng"
            cell.authorImageView.image = UIImage(named: "author")

        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "custom-segue-featured-1024")
            cell.postTitleLabel.text = "Building a Chat App in Swift Using Multipeer Connectivity Framework"
            cell.authorLabel.text = "Gabriel Theodoropoulos"
            cell.authorImageView.image = UIImage(named: "appcoda-300")
            
        } else {
            cell.postImageView.image = UIImage(named: "webkit-featured")
            cell.postTitleLabel.text = "A Beginner’s Guide to Animated Custom Segues in iOS 8"
            cell.authorLabel.text = "Gabriel Theodoropoulos"
            cell.authorImageView.image = UIImage(named: "appcoda-300")
            
        }

        return cell
    }
    

}
