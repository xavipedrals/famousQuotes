//
//  QuoteDetailViewController.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 12/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import UIKit
import Kingfisher

class QuoteDetailViewController: UIViewController {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bigLikeImageView: UIImageView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var doubleClickView: UIView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    
    var quote: Quote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVisuals()
        
        configDoubleTapGestureRecognizer()
        configNavigationBar()
        setupNavBar()
    }
    
    func initVisuals() {
//        if let imageUrl = quote?.backgroundImg, let url = URL(string: imageUrl) {
//            backImageView.kf.setImage(with: url)
//        }
        backImageView.setImage(url: quote?.backgroundImg)
        
        setBarButtonSize(button: likeButton)
        setBarButtonSize(button: starButton)
        
        authorImageView.layer.cornerRadius = 30
        authorImageView.clipsToBounds = true
        authorImageView.layer.borderWidth = 1
        authorImageView.layer.borderColor = UIColor.white.cgColor
//        if let authorImage = quote?.authorPhoto, let url = URL(string: authorImage) {
//            authorImageView.kf.setImage(with: url)
//        }
        authorImageView.setImage(url: quote?.authorPhoto)
        
        quoteLabel.text = quote?.text!
        authorLabel.text = quote?.authorName!
    }
    
    func setBarButtonSize(button: UIButton) {
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
    
    func setupNavBar() {
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func configNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    func configDoubleTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        doubleClickView.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapped() {
        let bigLikeAnimation = BigLikeAnimation(view: bigLikeImageView)
        let smallLikeAnimation = LikeAnimation(view: likeImageView)
        bigLikeAnimation.startAnimation()
        smallLikeAnimation.startAnimation()
    }
    
    @IBAction func likePressed(_ sender: Any) {
        likeImageView.image = UIImage(named: "like-red")
    }
    
    @IBAction func starPressed(_ sender: Any) {
        let smallLikeAnimation = LikeAnimation(view: starImageView)
        smallLikeAnimation.startAnimation()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
