//
//  ListTableViewCell.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 11/24/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionMuseums: UICollectionView!
    @IBOutlet weak var title: UILabel!
}
    extension ListTableViewCell {
        
        func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
            
            collectionMuseums.delegate = dataSourceDelegate
            collectionMuseums.dataSource = dataSourceDelegate
            collectionMuseums.tag = row
            collectionMuseums.setContentOffset(collectionMuseums.contentOffset, animated:false) // Stops collection view if it was scrolling.
            collectionMuseums.reloadData()
        }
        
        var collectionViewOffset: CGFloat {
            set { collectionMuseums.contentOffset.x = newValue }
            get { return collectionMuseums.contentOffset.x }
        }
}
