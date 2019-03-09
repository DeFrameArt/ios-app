//
//  TableViewOfMuseumCollectionViewController.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 2/2/19.
//  Copyright © 2019 DeFrame. All rights reserved.
//

import UIKit

class TableViewOfMuseumCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    let maxHeight: CGFloat = 250.0
    let minHeight: CGFloat = 50.0
    @IBOutlet weak var tableView: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TableViewOfMuseumCollectionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  let key = Array(museumDictionaries.keys)[indexPath.row]
       return museumDictionaries.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell") as! TableCellCollectionOfMuseumsTableViewCell
        cell.number=indexPath.row
        let key = Array(museumDictionaries.keys)[indexPath.row]
        cell.label.text = key
        return cell
    }
}
