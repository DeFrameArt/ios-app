//
//  TableCellCollectionOfMuseumsTableViewCell.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 2/2/19.
//  Copyright © 2019 DeFrame. All rights reserved.
//

import UIKit

class TableCellCollectionOfMuseumsTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var number:Int = 0
    var counts=0
   // var rowNumber
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TableCellCollectionOfMuseumsTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = Array(museumDictionaries.keys)[number]
        var itemsIndex:Int = (museumDictionaries[key]?.count)!
       // number=key.count
         return itemsIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionCellOfCollectionMuseumsCollectionViewCell
     
        
        var itemsIndex = museumDictionaries[label.text as! String]?.count
        print(itemsIndex)
        print(counts)
        if(counts<=itemsIndex!){
            var items = museumDictionaries[label.text as! String]?[counts]
        // cell.imageView.sd_setImage(with: URL(string: museum[indexPath.row].bannerURL!))
        cell.image.sd_setImage(with: URL(string:(items?.bannerURL)!))
        counts=counts+1
        }
        if counts==itemsIndex{
            counts=0
        }
        
        return cell
    }
}

extension TableCellCollectionOfMuseumsTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionViewCell selected \(indexPath)")
    }
    
}
