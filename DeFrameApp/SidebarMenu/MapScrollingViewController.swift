//
//  MapScrollingViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 6/18/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit
import CoreLocation
import FBSDKCoreKit
import FBSDKLoginKit
import CoreData
import BubbleTransition
import MaterialComponents.MaterialTypography
import DGRunkeeperSwitch
import Tamamushi
import ScalingCarousel

class Cell: ScalingCarouselCell {}

class MapScrollingViewController: UIViewController {


        
        // MARK: - IBOutlets
       // @IBOutlet weak var carousel: ScalingCarouselView!
  
    @IBOutlet weak var carousel: ScalingCarouselView!
    @IBOutlet weak var carouselBottomConstraint: NSLayoutConstraint!
      //  @IBOutlet weak var output: UILabel!
    
        private struct Constants {
            static let carouselHideConstant: CGFloat = -250
            static let carouselShowConstant: CGFloat = 15
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
           // carouselBottomConstraint.constant = Constants.carouselHideConstant
        }
    
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
           // carousel.deviceRotated()
        }
        // MARK: - Button Actions
        
        @IBAction func showHideButtonPressed(_ sender: Any) {
            
            carouselBottomConstraint.constant = (carouselBottomConstraint.constant == Constants.carouselShowConstant ? Constants.carouselHideConstant : Constants.carouselShowConstant)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
   
    }
    
    typealias CarouselDatasource = MapScrollingViewController
    extension CarouselDatasource: UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            if let scalingCell = cell as? ScalingCarouselCell {
                scalingCell.mainView.backgroundColor = .red
            }
            
            DispatchQueue.main.async {
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
            }
            
            return cell
        }
    }
    
    typealias CarouselDelegate = MapScrollingViewController
    extension MapScrollingViewController: UICollectionViewDelegate {
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            //carousel.didScroll()
            
            guard let currentCenterIndex = carousel.currentCenterCellIndex?.row else { return }
            
          //  output.text = String(describing: currentCenterIndex)
        }
    }
    
    private typealias ScalingCarouselFlowDelegate = MapScrollingViewController
    extension ScalingCarouselFlowDelegate: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            
            return 0
        }
}
