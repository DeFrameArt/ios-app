//
//  ViewControllerMuseumList.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 11/24/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit
func generateRandomData() -> [[UIColor]] {
    let numberOfRows = 20
    let numberOfItemsPerRow = 15
    
    return (0..<numberOfRows).map { _ in
        return (0..<numberOfItemsPerRow).map { _ in UIColor.randomColor() }
    }
}
class ViewControllerMuseumList: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var gradient: CAGradientLayer!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var selectedRow = 0
    let model = generateRandomData()
    var storedOffsets = [Int: CGFloat]()
        var museum = [Museum(id:"12", name:"Museum", acronym:"212", street:"Museum", city:"Museum", state:"State", country:"State", zip:"Zip", lat:32.33, lon:32.33, bannerURL:"String", logoURL:"String"), Museum(id:"12", name:"Museum", acronym:"212", street:"Museum", city:"Museum", state:"State", country:"State", zip:"Zip", lat:32.33, lon:32.33, bannerURL:"String", logoURL:"String")]
    
    var listCities=[String]()
      var unique=[String]()
    
    override func viewDidLayoutSubviews() {
        let gradient = CAGradientLayer()
        gradient.frame.size = self.topView.bounds.size
        //gradient.frame = view.bounds
        gradient.frame.size = self.topView.bounds.size
        gradient.colors = [UIColor(red:0.82, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.80, green:0.26, blue:0.48, alpha:1.0).cgColor,UIColor(red:0.75, green:0.26, blue:0.48, alpha:1.0).cgColor, UIColor(red:0.60, green:0.26, blue:0.48, alpha:1.0).cgColor]
        
        topView.layer.insertSublayer(gradient, at: 0)
        
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        museum=allMuseums
          self.navigationController?.isNavigationBarHidden = true
      //  UIApplication.shared.isStatusBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent

        for city in museum{
            listCities.append(city.city!)
        }
        unique=Array(Set(listCities))
        
        print(unique.count)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return museumDictionaries.count
    }
    


    
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
    
    
    let key = Array(museumDictionaries.keys)[indexPath.row]
    cell.title.text = key
        return cell
    }
    
  
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? ListTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? ListTableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath1 = tableView.indexPathForSelectedRow
        let sectionNumber = indexPath1?.section
        print(sectionNumber as Any)
    }
    
}

extension ViewControllerMuseumList: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return museumDictionaries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! CollectionViewCellListView
       // let artImageView = cell.viewWithTag(1) a UIImageView
        
        //print(artPageImageURLsArray[indexPath.row])
    
        //museumDictionaries.keys)[indexPath.row]
        
        cell.imageView.sd_setImage(with: URL(string: museum[indexPath.row].bannerURL!))
       // cell.backgroundColor = model[collectionView.tag][indexPath.item]
        //museumDictionaries
        
        return cell
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    

        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        selectedRow=collectionView.tag
        print(selectedRow)
        self.performSegue(withIdentifier: "museumDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "museumDetails"){
            // self.tableView.cellForRow(at: )
            //  tableView.cellForRow(at: selectedRow)
            tableView.cellForRow(at: IndexPath(row: selectedRow, section: 0))
            //tableView.indexPathForSelectedRow(selectedRow)
        }
    }

}
extension UIColor {
    
    class func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}

extension Array where Element : Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}
