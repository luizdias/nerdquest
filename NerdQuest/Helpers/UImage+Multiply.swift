//
//  UImage+Multiply.swift
//  NerdQuest
//
//  Created by Luiz Fernando Aquino Dias on 05/03/17.
//  Copyright © 2017 Town Tree. All rights reserved.
//

import UIKit

extension UIImage{

    class func multiply(image:UIImage, color:UIColor, alpha: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: image.size)
        
        //image colored
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //image multiply
        UIGraphicsBeginImageContextWithOptions(image.size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        
        // fill the background with white so that translucent colors get lighter
        context!.setFillColor(UIColor.white.cgColor)
        context!.fill(rect)
        
        image.draw(in: rect, blendMode: .normal, alpha: 1)
        coloredImage?.draw(in: rect, blendMode: .multiply, alpha: alpha)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
    
}
