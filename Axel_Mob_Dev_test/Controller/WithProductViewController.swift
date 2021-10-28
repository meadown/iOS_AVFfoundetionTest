//
//  WithProductViewController.swift
//  Axel_Mob_Dev_test
//
//  Created by Meadown on 28/10/21.
//

import UIKit

class WithProductViewController: UIViewController {

    @IBOutlet weak var imgScan: UIImageView!{
        didSet{
            let tapgesture  = UITapGestureRecognizer(target: self, action: #selector(scan))
            imgScan.addGestureRecognizer(tapgesture)
            imgScan.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var productsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsTable.delegate = self
        productsTable.dataSource = self
    
    }

    @objc func scan(){
        performSegue(withIdentifier: "scan", sender: self)
    }

}

