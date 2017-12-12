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
    
    var quote: Quote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageUrl = quote?.backgroundImg, let url = URL(string: imageUrl) {
            backImageView.kf.setImage(with: url)
        }
        self.navigationController?.navigationBar.isHidden = true
        
        authorImageView.layer.cornerRadius = 30
        authorImageView.clipsToBounds = true
        authorImageView.layer.borderWidth = 1
        authorImageView.layer.borderColor = UIColor.white.cgColor
        if let authorImage = quote?.authorPhoto, let url = URL(string: authorImage) {
            authorImageView.kf.setImage(with: url)
        }
        
        quoteLabel.text = quote?.text!
        authorLabel.text = quote?.authorName!
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
