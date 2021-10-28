//
//  Extensions.swift
//  Axel_Mob_Dev_test
//
//  Created by Meadown on 28/10/21.
//

import Foundation
import UIKit

//MARK: extension for managing productsTable data:
extension WithProductViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManagetData.shared.productsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell") as! ProductsTableCell
        
        cell.lblSerial.text = "Scan No: \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ManagetData.shared.currentIndex = indexPath.row
        performSegue(withIdentifier: "product", sender: self)
    }
    
}


//MARK: extension for managing productTable data:
extension ViewProductController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewProductCell") as! ProductTableCell
        
        cell.lblDetails.text = ManagetData.shared.QRarray[ManagetData.shared.currentIndex]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 800
    }
   
}


//MARK: extension for managing reviewScanTable data:
extension ReviewScanController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewScan") as! ReviewScanTableCell
        
        cell.lblDetails.text = ManagetData.shared.qrDetails
        ManagetData.shared.QRarray.append(ManagetData.shared.qrDetails)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        reviewScanTable.rowHeight = UITableView.automaticDimension
        
        return 800
    }

}

