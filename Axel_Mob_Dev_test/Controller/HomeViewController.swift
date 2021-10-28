//
//  HomeViewController.swift
//  Axel_Mob_Dev_test
//
//  Created by Meadown on 28/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: Container Oulates
    @IBOutlet weak var ContainerNoProduct: UIView!
    @IBOutlet weak var ContainerWithProduct: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContainer()

        // Do any additional setup after loading the view.
    }
    
    
    func setContainer(){
        
        if ManagetData.shared.productsCount > 0{
            ContainerNoProduct.isHidden = true
            ContainerWithProduct.isHidden = false
        }else{
            ContainerNoProduct.isHidden = false
            ContainerWithProduct.isHidden = true
        }
    }
    
}
