//
//  CollectionViewCellMainPage.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 8/5/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit

class CollectionViewCellMainPage: UICollectionViewCell {
    @IBOutlet weak var tapButton: UIButton!
    var index=0
    @IBOutlet weak var imageViewMain: UIImageView!
    func set(image: UIImage?) {
       imageViewMain.image = image
     
    }
}
