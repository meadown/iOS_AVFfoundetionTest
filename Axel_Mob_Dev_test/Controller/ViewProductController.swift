//
//  ViewProductController.swift
//  Axel_Mob_Dev_test
//
//  Created by Meadown on 28/10/21.
//

import UIKit

class ViewProductController: UIViewController {
    
    //MARK: All images Outlate
    
    @IBOutlet weak var imgBack: UIImageView!{
        didSet{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToHome))
            imgBack.addGestureRecognizer(tapGesture)
            imgBack.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var imgScan: UIImageView!{
        didSet{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToScan))
            imgScan.addGestureRecognizer(tapGesture)
            imgScan.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var viewProductTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewProductTable.delegate = self
        viewProductTable.dataSource = self
        
    }
    
    @objc func goToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "home")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        
    }
    
    @objc func goToScan(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "scan")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }

}


    



