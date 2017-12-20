//
//  Commons.swift
//  InternetTV
//
//  Created by Xavier Pedrals on 19/10/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import UIKit
import Kingfisher

class Environment {
    static let jsonParsingMethod = JSONParsingMethod.soft
}

extension UIRefreshControl {
    convenience init(tint: UIColor, background: UIColor) {
        self.init()
        self.tintColor = tint
        self.backgroundColor = background
    }
}

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 50.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
    
    func resetScrollPositionToTop() {
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
}

extension UIImageView {
    func setImage(url: String?) {
        if let imageUrl = url, let realUrl = URL(string: imageUrl) {
            self.kf.setImage(with: realUrl)
        }
    }
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
    
    convenience init(hex:Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    
}
