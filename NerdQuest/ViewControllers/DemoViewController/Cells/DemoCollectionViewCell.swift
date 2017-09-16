//
//  DemoCollectionViewCell.swift
//  TestCollectionView
//
//  Created by Luiz Dias. on 12/05/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit
//import Alamofire

class DemoCollectionViewCell: BasePageCollectionCell {

    //TODO: Networking disabled for this MVP version. Re-enable it here:
//    var request: Alamofire.Request?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var customTitle: UILabel!
    @IBOutlet weak var questionsAvailable: UILabel!

    @IBOutlet weak var categoryPriceButton: UIButton!
    @IBAction func buyCategoryPack(_ sender: UIButton) {
        let alertController = UIAlertController(title: "In App Purchase", message:
            "Fazer conexão do In App Purchase.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

    override func awakeFromNib() {
        
        super.awakeFromNib()
        customTitle.layer.shadowRadius = 2
        customTitle.layer.shadowOffset = CGSize(width: 0, height: 3)
        customTitle.layer.shadowOpacity = 0.2

//        categoryPriceButton.backgroundColor = UIColor.init(red: 36.0/255, green: 185.0/255, blue: 98.0/255, alpha: 1.0)
    }
    
//    override func layoutSubviews() {
//        
//        categoryPriceButton.backgroundColor = UIColor.clearColor()
//        categoryPriceButton.layer.cornerRadius = 26
//        categoryPriceButton.layer.borderWidth = 0
//        categoryPriceButton.layer.borderColor = UIColor.whiteColor().CGColor
//        categoryPriceButton.titleLabel?.text = "$0.99"
//        
//    }
}
