//
//  EmptyProductViewController.swift
//  Axel_Mob_Dev_test
//
//  Created by Meadown on 28/10/21.
//

import UIKit

class EmptyProductViewController: UIViewController {

//MARk: Allimagefield  outlates
    @IBOutlet weak var imgScan: UIImageView!{
        didSet{
            let tapgesture  = UITapGestureRecognizer(target: self, action: #selector(scan))
            imgScan.addGestureRecognizer(tapgesture)
            imgScan.isUserInteractionEnabled = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func scan(){
        performSegue(withIdentifier: "scan", sender: self)
    }


}
