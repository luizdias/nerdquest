//
//  NavigationController+BackButton.swift
//  NerdQuest
//
//  Created by Luiz Fernando Aquino Dias on 04/07/17.
//  Copyright © 2017 Town Tree. All rights reserved.
//

import UIKit

protocol NavigationControllerBackButtonDelegate {
    func shouldPopOnBackButtonPress() -> Bool
}

extension UINavigationController {
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        // Prevents from a synchronization issue of popping too many navigation items
        // and not enough view controllers or viceversa from unusual tapping
        if viewControllers.count < navigationBar.items!.count {
            return true
        }
        
        // Check if we have a view controller that wants to respond to being popped
        var shouldPop = true
        if let viewController = topViewController as? NavigationControllerBackButtonDelegate {
            shouldPop = viewController.shouldPopOnBackButtonPress()
        }
        
        if (shouldPop) {
            DispatchQueue.main.async {
                self.popViewController(animated: true)
            }
        } else {
            // Prevent the back button from staying in an disabled state
            for view in navigationBar.subviews {
                if view.alpha < 1.0 {
                    UIView.animate(withDuration: 0.25, animations: {
                        view.alpha = 1.0
                    })
                }
            }
            
        }
        
        return false
    }
}
