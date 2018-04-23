//
//  MuseumTableViewCell.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 4/4/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit

class MuseumTableViewCell: UITableViewCell {
   
    @IBOutlet weak var imageM: UIImageView!
    @IBOutlet weak var titleMuseum: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
