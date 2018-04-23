//
//  MuseumListTableViewCell.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 4/1/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit

class MuseumListTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var museumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
