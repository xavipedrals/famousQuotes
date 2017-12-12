//
//  LikeAnimations.swift
//  MyQuotes
//
//  Created by Xavi on 19/09/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

protocol Animatable {
    func startAnimation()
}

class BounceAnimation {
    
    var view: UIView
    let bigTransform = CGAffineTransform(scaleX: 1.4, y: 1.4)
    let normalTransform = CGAffineTransform(scaleX: 1, y: 1)
    let smallTransform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    let fadeOutTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    
    fileprivate init(view: UIView) {
        self.view = view
    }
    
    fileprivate func bigSizeIncrease(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1
            self.view.transform = self.bigTransform
        }, completion: { value in
            completion()
        })
    }
    
    fileprivate func turnNormalSize(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15, animations: {
            self.view.transform = self.normalTransform
        }, completion: { value in
            completion()
        })
    }
    
    fileprivate func smallSizeIncrease(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15, animations: {
            self.view.transform = self.smallTransform
        }, completion: { value in
            completion()
        })
    }
    
    fileprivate func fadeOut() {
        UIView.animate(withDuration: 0.15, delay: 0.15, animations: {
            self.view.transform = self.fadeOutTransform
            self.view.alpha = 0
        }, completion: {
            value in
            self.view.transform = self.normalTransform
            self.view.isHidden = true
        })
    }
}

class LikeAnimation: BounceAnimation, Animatable {
    
    override init(view: UIView) {
        super.init(view: view)
    }
    
    func startAnimation() {
        bigSizeIncrease {
            self.turnNormalSize {
                self.smallSizeIncrease {
                    self.turnNormalSize {}
                }
            }
        }
    }
}

class BigLikeAnimation: BounceAnimation, Animatable {
    
    override init(view: UIView) {
        super.init(view: view)
    }
    
    func startAnimation() {
        self.view.isHidden = false
        bigSizeIncrease {
            self.turnNormalSize {
                self.smallSizeIncrease {
                    self.fadeOut()
                }
            }
        }
    }
}


