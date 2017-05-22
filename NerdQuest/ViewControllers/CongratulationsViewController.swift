//
//  CongratulationsViewController.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias on 8/14/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit
import TKSwarmAlert

class ViewController: UIViewController {
    
//    let swAlert = TKSwarmAlert(backgroundType: .blur(style:UIBlurEffectStyle(rawValue: 100)!, blackAlpha:CGFloat(100.0)))
    let swAlert = TKSwarmAlert(backgroundType: .blur)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showButton = UIButton()
        showButton.backgroundColor = UIColor(red:0.976471, green: 0.635294, blue: 0.168627, alpha: 1)
        showButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        showButton.center = CGPoint(x: view.center.x, y: view.center.y - 100)
        showButton.setTitle("show", for: .normal)
        showButton.addTarget(self, action: #selector(onTapShowButton), for: UIControlEvents.touchUpInside)
        view.addSubview(showButton)
        
        let spawnButton = UIButton()
        spawnButton.frame = CGRect(x: 20, y: 40, width: 100, height: 44)
        spawnButton.backgroundColor = UIColor.gray
        spawnButton.alpha = 0.6
        spawnButton.setTitle("spawn", for: .normal)
        spawnButton.addTarget(self, action: #selector(onTapSpawnButton), for: UIControlEvents.touchUpInside)
        swAlert.addSubStaticView(spawnButton)
        
        swAlert.didDissmissAllViews = {
            print("didDissmissAllViews")
        }
    }
    
    func onTapShowButton() {
        self.showAlert()
    }
    
    func onTapSpawnButton() {
        let popoverContent = (self.storyboard?.instantiateViewController(withIdentifier: "Result"))! as UIViewController
        
        self.swAlert.spawn([popoverContent.view!])
        self.swAlert.addNextViews([popoverContent.view!])
    }
    
    func showAlert() {
        let popoverContent = (self.storyboard?.instantiateViewController(withIdentifier: "Result"))! as UIViewController
        swAlert.show([popoverContent.view!])
        swAlert.addNextViews([popoverContent.view!])
        swAlert.addNextViews([popoverContent.view!])
    }
}



