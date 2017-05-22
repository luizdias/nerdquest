//
//  StoryboardHelper.swift
//  TestCollectionView
//
//  Created by Luiz Dias. on 10/05/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit

extension UIStoryboard {
  
  enum Storyboard : String {
    case Main
  }
  
  convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
    self.init(name: storyboard.rawValue, bundle: bundle)
  }
  
  class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
    return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
  }
  
  func instantiateViewController<T: UIViewController where T: StoryboardIdentifiable>() -> T {
    guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
      fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
    }
    
    return viewController
  }
}

extension UIViewController : StoryboardIdentifiable { }

// MARK: identifiable

protocol StoryboardIdentifiable {
  static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
  static var storyboardIdentifier: String {
    return String(describing: self)
  }
}
