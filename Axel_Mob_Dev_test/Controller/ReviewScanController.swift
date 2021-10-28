//
//  ReviewScanController.swift
//  Axel_Mob_Dev_test
//
//  Created by Meadown on 28/10/21.
//

import UIKit

class ReviewScanController: UIViewController {

    //MARK: all images Outlate
    @IBOutlet weak var imgRescan: UIImageView!{
        didSet{
            let tapGesture = UITapGestureRecognizer (target: self, action: #selector(goToScan))
            imgRescan.addGestureRecognizer(tapGesture)
            imgRescan.isUserInteractionEnabled = true
        }
        
    }
    
    @IBOutlet weak var imgConfirm: UIImageView!{
        didSet{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToHome))
            imgConfirm.addGestureRecognizer(tapGesture)
            imgConfirm.isUserInteractionEnabled = true
        }
    }
    
    
    @IBOutlet weak var reviewScanTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reviewScanTable.delegate = self
        reviewScanTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    @objc func goToScan (){
        performSegue(withIdentifier: "scan", sender: self)
    }
    
    @objc func goToHome(){
        ManagetData.shared.productsCount =  ManagetData.shared.productsCount + 1
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "home")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        
    }
    
}

