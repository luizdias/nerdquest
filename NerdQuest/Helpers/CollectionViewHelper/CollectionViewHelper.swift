//
//  CollectionViewHelper.swift
//  TestCollectionView
//
//  Created by Luiz Dias. on 04/05/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit

extension UICollectionView {
  func getReusableCellWithIdentifier<T: UICollectionViewCell where T: CollectionViewCellIdentifiable>(indexPath: NSIndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath as IndexPath) as? T else {
      fatalError("Couldn't instantiate view controller with identifier \(T.cellIdentifier) ")
    }
    
    return cell
  }
}

// MARK: UITableViewCell

protocol CollectionViewCellIdentifiable {
  static var cellIdentifier: String { get }
}

extension CollectionViewCellIdentifiable where Self: UICollectionViewCell {
  static var cellIdentifier: String {
    return String(describing: self)
  }
}

extension UICollectionViewCell : CollectionViewCellIdentifiable { }
