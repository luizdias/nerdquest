//
//  AnimationBarButton.swift
//  TestCollectionView
//
//  Created by Alex K. on 23/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class AnimatingBarButton: UIBarButtonItem, Rotatable {
    
    @IBInspectable var normalImageName: String = ""
    @IBInspectable var selectedImageName: String = ""
    
    @IBInspectable var duration: Double = 1
    
    let normalView = UIImageView(frame: .zero)
    let selectedView = UIImageView(frame: .zero)
}

// MARK: life cicle

extension AnimatingBarButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        //    customView?.backgroundColor = .redColor()
        
        configurateImageViews()
    }
}

// MARK: public

extension AnimatingBarButton {
    
    func animationSelected(selected: Bool) {
        if selected {
            rotateAnimationFrom(fromItem: normalView, toItem: selectedView, duration: duration)
        } else {
            rotateAnimationFrom(fromItem: selectedView, toItem: normalView, duration: duration)
        }
    }
}

// MARK: Create

extension AnimatingBarButton {
    
    func configurateImageViews() {
        configureImageView(imageView: normalView, imageName: normalImageName)
        configureImageView(imageView: selectedView, imageName: selectedImageName)
        
        selectedView.alpha = 0
        //    normalView.hidden = true
    }
    
    private func configureImageView(imageView: UIImageView, imageName: String) {
        guard let customView = customView else { return }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        //    imageView.backgroundColor = .greenColor()
        
        //    imageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        customView.addSubview(imageView)
        
        // add constraints
        [(NSLayoutAttribute.centerX, 12), (.centerY, -1)].forEach { info in
            _ = (customView, imageView) >>>- {
                $0.attribute = info.0
                $0.constant = CGFloat(info.1)
            }
        }
        
        [NSLayoutAttribute.height, .width].forEach { attribute in
            _ = imageView >>>- {
                $0.attribute = attribute
                $0.constant = 20
            }
        }
    }
}
