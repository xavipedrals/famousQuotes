//
//  RecentViewModel.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 12/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import Foundation
import RxSwift

class RecentViewModel: BaseListViewModel {
    
    typealias Element = Quote
    var defaultOffset = 10
    var data = Variable<[Quote]>([])
    var isDataRefreshing = false
    var quotesGetter: AlamofireGetter<Quote>
    
    init() {
        quotesGetter = AlamofireGetter(url: "https://myquotesserver.herokuapp.com/api/quotes/recent", indexs: [])
        getData(offset: 0)
    }
    
    func getData(offset: Int) {
        if (!isDataRefreshing) {
            isDataRefreshing = true
            quotesGetter.get(offset: offset, completion: { quotes in
                self.data.value = quotes
                self.isDataRefreshing = false
            })
        }
    }
    
    func getMoreData() {
        
    }
    
    
}
