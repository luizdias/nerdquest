//
//  PointsEarnedViewController.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias on 8/20/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit

class PointsEarnedViewController: UIViewController {
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 12
        popupView.layer.borderColor = UIColor.black.cgColor
        popupView.layer.borderWidth = 0.25
        popupView.layer.shadowColor = UIColor.black.cgColor
        popupView.layer.shadowOpacity = 0.6
        popupView.layer.shadowRadius = 15
        popupView.layer.shadowOffset = CGSize(width: 5, height: 5)
        popupView.layer.masksToBounds = false
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
}
