//
//  UIViewControllerExtension.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias on 6/20/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showHUD(){
        let loading = MBProgressHUD.showAdded(to: (UIApplication.shared.delegate as! AppDelegate).window, animated: true)
        loading?.isUserInteractionEnabled = true
    }
    
    func hideHUD() {
        MBProgressHUD.hideAllHUDs(for: (UIApplication.shared.delegate as!
            AppDelegate).window, animated: true)
    }
    
}


extension UserDefaults {
    func setString(string:String, forKey:String) {
        UserDefaults().set(string, forKey: forKey)
    }
}
