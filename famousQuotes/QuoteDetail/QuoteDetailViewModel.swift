//
//  QuoteDetailViewModel.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 15/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import RxSwift

class QuoteDetailViewModel {
    var userHasLiked = false
    var likeCount: Int
    
    init(quote: Quote) {
        self.likeCount = quote.likeCount!
    }
    
    
}
