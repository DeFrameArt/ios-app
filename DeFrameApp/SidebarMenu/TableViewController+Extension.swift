//
//  TableViewController+Extension.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 7/24/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadWithAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
            //UIView.animate(withDuration: 1.6, delay: 0.1 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            UIView.animate(withDuration: 1, delay: 0.2 * Double(delayCounter), options: [.curveEaseInOut], animations: {
                
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
