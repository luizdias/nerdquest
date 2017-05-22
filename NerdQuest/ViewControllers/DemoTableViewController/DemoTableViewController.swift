//
//  DemoTableViewController.swift
//  TestCollectionView
//
//  Created by Luiz Dias. on 24/05/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit

class DemoTableViewController: ExpandingTableViewController {
  
    @IBAction func backButton(_ sender: AnyObject) {
     
        // buttonAnimation
        let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []
        
        for viewController in viewControllers {
            if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(selected: false)
            }
        }
        popTransitionAnimation()
    }

  var scrollOffsetY: CGFloat = 0
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar()
    tableView.backgroundView = UIImageView(image: UIImage.Asset.BackgroundImage.image)
  }
}
// MARK: Helpers

extension DemoTableViewController {
  
    //TODO: check why this function bellow cannot be private as it was before (swift 2.3)
   func configureNavBar() {
    navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
  }
}

// MARK: Actions

extension DemoTableViewController {
  
  @IBAction func backButtonHandler(sender: AnyObject) {
    // buttonAnimation
    let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []

    for viewController in viewControllers {
      if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
        rightButton.animationSelected(selected: false)
      }
    }
    popTransitionAnimation()
  }
}

// MARK: UIScrollViewDelegate

extension DemoTableViewController {
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < -25 {
      // buttonAnimation
      let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []

      for viewController in viewControllers {
        if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
          rightButton.animationSelected(selected: false)
        }
      }
      popTransitionAnimation()
    }
    
    scrollOffsetY = scrollView.contentOffset.y
  }
}
