//
//  QuoteDetailViewController.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 12/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

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
    var viewModel: QuoteDetailViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = QuoteDetailViewModel(quote: quote!)
        initVisuals()
        
        configDoubleTapGestureRecognizer()
        configNavigationBar()
        setupNavBar()
    }
    
    func initVisuals() {
        backImageView.setImage(url: quote?.backgroundImg)
        
        setBarButtonSize(button: likeButton)
        setBarButtonSize(button: starButton)
        
        authorImageView.layer.cornerRadius = 30
        authorImageView.clipsToBounds = true
        authorImageView.layer.borderWidth = 1
        authorImageView.layer.borderColor = UIColor.white.cgColor
        authorImageView.setImage(url: quote?.authorPhoto)
        
        quoteLabel.text = quote?.text!
        authorLabel.text = quote?.authorName!
        viewModel?.likeCount.asObservable()
            .map({ return "\($0)" })
            .bind(to: likeCountLabel.rx.text)
            .disposed(by: disposeBag)
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
        likePressed("DoubleTap")
        bigLikeAnimation.startAnimation()
    }
    
    @IBAction func likePressed(_ sender: Any) {
        if let sender = sender as? String {
            if sender == "DoubleTap" {
                likeImageView.image = UIImage(named: "like-red")
                viewModel?.userHasLiked = true
            }
        }
        else {
            likeImageView.image = viewModel!.userHasLiked
                ? UIImage(named: "like")
                : UIImage(named: "like-red")
            viewModel?.userHasLiked = !viewModel!.userHasLiked
        }
        let smallLikeAnimation = LikeAnimation(view: likeImageView)
        smallLikeAnimation.startAnimation()
    }
    
    @IBAction func starPressed(_ sender: Any) {
        starImageView.image = !viewModel!.isFavourite
            ? UIImage(named: "star")
            : UIImage(named: "star-white")
        
        let smallLikeAnimation = LikeAnimation(view: starImageView)
        smallLikeAnimation.startAnimation()
        viewModel?.isFavourite = !viewModel!.isFavourite
    }
    
}
