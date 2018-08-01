//
//  TabViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 7/4/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit
import FoldingTabBar
import Tamamushi
open class TabViewController: YALFoldingTabBarController {
   let layerGradient = CAGradientLayer()
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
    override open func viewDidLoad() {
        super.viewDidLoad()
          let item1 = YALTabBarItem(itemImage: UIImage(named: "nearby_icon"), leftItemImage: nil, rightItemImage: nil)
        let item2 = YALTabBarItem(itemImage: UIImage(named: "profile_icon"), leftItemImage: nil, rightItemImage: nil)
        
        let item3 = YALTabBarItem(itemImage: UIImage(named: "search_icon"), leftItemImage: nil, rightItemImage: nil)
        let item4 = YALTabBarItem(itemImage: UIImage(named: "settings_icon"), leftItemImage: nil, rightItemImage: nil)

     //   layerGradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
    //    layerGradient.startPoint = CGPoint(x: 0, y: 0.5)
   //     layerGradient.endPoint = CGPoint(x: 1, y: 0.5)
    //    layerGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
     //   tabBar.layer.addSublayer(layerGradient)
        
        //customize tabBarView
      //  tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
       // tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
        
        tabBarView.tabBarColor = UIColor(red: 94.0/255.0, green: 91.0/255.0, blue: 149.0/255.0, alpha: 1)
        
       // tabBarView.tabBarColor = UIColor(red: 72.0/255.0, green: 211.0/255.0, blue: 178.0/255.0, alpha: 1)
       //tabBarViewHeight = YALTabBarViewDefaultHeight;
      // tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
      // tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
        super.leftBarItems = [item1,item2]
        super.rightBarItems=[item3,item4]
        super.centerButtonImage = UIImage(named: "plus_icon")!
        super.selectedIndex=0
        
    
      
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
   
    
    // Handler for raised button

    
}
