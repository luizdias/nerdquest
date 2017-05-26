//
//  CategoriesCollectionViewCell.swift
//  NerdQuest
//
//  Created by Luiz Fernando Aquino Dias on 22/05/17.
//  Copyright © 2017 Town Tree. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public API
    var category: Category! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Private
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    fileprivate func updateUI()
    {
        categoryTitleLabel?.text! = category.title
        // TODO: Fix image here, retrieve from URL and pass here:
        imageView?.image! = UIImage(named: "image")!
//        imageView?.image! = UIImage(data: category.image as Data)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CategoriesCollectionViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}






















