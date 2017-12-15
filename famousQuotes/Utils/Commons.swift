//
//  Commons.swift
//  InternetTV
//
//  Created by Xavier Pedrals on 19/10/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import UIKit
import Kingfisher

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
