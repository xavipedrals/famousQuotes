//
//  QuoteDetailViewModel.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 15/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import RxSwift

class QuoteDetailViewModel {
    var userHasLiked: Bool {
        set {
            if userHasLiked != newValue {
                if newValue { likeCount.value += 1}
                else { likeCount.value -= 1 }
                self.aux = newValue
            }
        }
        get {
            return self.aux
        }
    }
    private var aux = false
    var isFavourite = false
    private let userHasLikedObs = Variable<Int>(0)
    var likeCount = Variable<Int>(0)
    let disposeBag = DisposeBag()
    
    init(quote: Quote) {
        self.likeCount.value = quote.likeCount!
    }
}
