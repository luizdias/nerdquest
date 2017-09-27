//
//  CategoriesCollectionViewCell.swift
//  NerdQuest
//
//  Created by Luiz Fernando Aquino Dias on 22/05/17.
//  Copyright © 2017 Town Tree. All rights reserved.
//

import UIKit
//import QuartzCore

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public API
    var category: Category! {
        didSet {
            updateUI()
        }
    }
    
    var cellDelegate : CategoriesCellDelegate?
    
    @IBAction func buyOrPlay(_ sender: UIButton) {
        if(self.cellDelegate != nil){ //Just to be safe.
            self.cellDelegate?.callSegueFromCell(myData: "testy" as AnyObject)
        }
    }
    
    // MARK: - Private
    @IBOutlet weak var promotionalTagLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var buyOrPlayButton: UIButton!
    @IBOutlet weak var price: UIButton!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var numberOfQuestions: UILabel!
    
    var freeCategory = false
    
    fileprivate func updateUI()
    {
        categoryTitleLabel?.text! = category.title
        // TODO: Fix image here, retrieve from URL and pass here:
        imageView?.image! = UIImage(named: "image")!
//        imageView?.image! = UIImage(data: category.image as Data)!
    }
    
    override func layoutSubviews() {
        promotionalTagLabel.layer.masksToBounds = true
        promotionalTagLabel.layer.cornerRadius = 10
        promotionalTagLabel.layer.backgroundColor = UIColor.orange.cgColor
        promotionalTagLabel.backgroundColor = UIColor.orange
        buyOrPlayButton.layer.cornerRadius = 26
        buyOrPlayButton.layer.borderWidth = 2
        buyOrPlayButton.layer.borderColor = UIColor.blue.cgColor
        buyOrPlayButton.titleLabel!.font = UIFont(name: "Montserrat-Bold", size: 15.0)
        buyOrPlayButton.setTitleColor(UIColor.blue, for: .normal)
        buyOrPlayButton.isHidden = true
        buyOrPlayButton.isEnabled = false
        details.sizeToFit()
        
        
//        self.freeCategory ? buyOrPlayButton.setTitle("Jogar!", for: .normal) : buyOrPlayButton.setTitle("Comprar", for: .normal)
        super.layoutSubviews()
        
        self.layer.cornerRadius = 14.0
        self.clipsToBounds = true
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CategoriesCollectionViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CategoriesCollectionViewCell
    }
}
