//
//  ConstraintsHelper.swift
//  TestCollectionView
//
//  Created by Luiz Dias. on 05/05/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit

struct ConstraintInfo {
    var attribute: NSLayoutAttribute = .left
    var secondAttribute: NSLayoutAttribute = .notAnAttribute
    var constant: CGFloat = 0
    var identifier: String?
    var relation: NSLayoutRelation = .equal
}

precedencegroup MultiplicationPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

infix operator >>>- : MultiplicationPrecedence

func >>>- <T: UIView> (left: (T, T), block: (inout ConstraintInfo) -> ()) -> NSLayoutConstraint {
    var info = ConstraintInfo()
    block(&info)
    info.secondAttribute = info.secondAttribute == .notAnAttribute ? info.attribute : info.secondAttribute
    
    let constraint = NSLayoutConstraint(item: left.1,
                                        attribute: info.attribute,
                                        relatedBy: info.relation,
                                        toItem: left.0,
                                        attribute: info.secondAttribute,
                                        multiplier: 1,
                                        constant: info.constant)
    constraint.identifier = info.identifier
    left.0.addConstraint(constraint)
    return constraint
}

func >>>- <T: UIView> (left: T, block: (inout ConstraintInfo) -> ()) -> NSLayoutConstraint {
    var info = ConstraintInfo()
    block(&info)
    
    let constraint = NSLayoutConstraint(item: left,
                                        attribute: info.attribute,
                                        relatedBy: info.relation,
                                        toItem: nil,
                                        attribute: info.attribute,
                                        multiplier: 1,
                                        constant: info.constant)
    constraint.identifier = info.identifier
    left.addConstraint(constraint)
    return constraint
}

func >>>- <T: UIView> (left: (T, T, T), block: (inout ConstraintInfo) -> ()) -> NSLayoutConstraint {
    var info = ConstraintInfo()
    block(&info)
    info.secondAttribute = info.secondAttribute == .notAnAttribute ? info.attribute : info.secondAttribute
    
    let constraint = NSLayoutConstraint(item: left.1,
                                        attribute: info.attribute,
                                        relatedBy: info.relation,
                                        toItem: left.2,
                                        attribute: info.secondAttribute,
                                        multiplier: 1,
                                        constant: info.constant)
    constraint.identifier = info.identifier
    left.0.addConstraint(constraint)
    return constraint
}

// MARK: UIView

extension UIView {
    
    func addScaleToFillConstratinsOnView(_ view: UIView) {
        [NSLayoutAttribute.left, .right, .top, .bottom].forEach { attribute in
            _ = (self, view) >>>- {
                $0.attribute = attribute
                $0.constant = 0
            }
        }
    }
    
    func getConstraint(_ attributes: NSLayoutAttribute) -> NSLayoutConstraint? {
        return constraints.filter {
            if $0.firstAttribute == attributes && $0.secondItem == nil {
                return true
            }
            return false
            }.first
    }
    
    
}
