//
//  ViewController.swift
//  Pay
//
//  Created by SBI Admin on 2020/05/25.
//  Copyright © 2020 SBI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var itemBackground: UIView!
    @IBOutlet weak var buyBackground: UIView!
    @IBOutlet weak var buyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
    }


}

extension ViewController {
    
    func configureUI(){
        itemBackground.itemBackgroundApply()
        buyBackground.itemBackgroundApply()
        
        buyButton.buttonApply()
    }
}



extension UIView {
    
    func itemBackgroundApply(){
        
        self.layer.cornerRadius     = 5
        self.layer.shadowRadius     = 5
        self.layer.shadowOpacity    = 0.2
        self.layer.shadowOffset     = CGSize(width: 4, height: 4)
        self.layer.shadowColor      = UIColor.lightGray.cgColor
        
    }
}

extension UIButton {
    func buttonApply(){
        self.layer.cornerRadius     = 5
    }
}

