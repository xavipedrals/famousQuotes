//
//  CardView.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 16/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    var cornerRadius: CGFloat = 15
    var shadowOffsetWidth: Int = 0
    var shadowOffsetHeight: Int = 12
    var shadowColor: UIColor? = UIColor.black
    var shadowOpacity: Float = 0.22
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = 14
        layer.shadowPath = shadowPath.cgPath
    }
    
}
