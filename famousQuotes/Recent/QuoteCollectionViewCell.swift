//
//  QuoteCollectionViewCell.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 12/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import UIKit
import Kingfisher

class QuoteCollectionViewCell: UICollectionViewCell, ReactiveCell {
    
    @IBOutlet weak var backgImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    func initCell(from: ParseableObj) {
        if let quote = from as? Quote {
            backgImageView.setImage(url: quote.backgroundImg)
            if let author = quote.authorName {
                authorLabel.text = author.uppercased()
            }
            if let text = quote.text {
                quoteLabel.text = text
            }
        }
        else {
            fatalError("QuoteCollectionViewCell needs a Quote to init")
        }
    }
}
