//
//  BaseListViewModel.swift
//  InternetTV
//
//  Created by Xavier Pedrals on 14/10/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseListViewModel: BaseListViewModelFunctions {
    associatedtype Element
    var defaultOffset: Int { get }
    var data: Variable<[Element]> { get }
    var isDataRefreshing: Bool { get }
}

protocol BaseListViewModelFunctions {
    func getData(offset: Int)
    func getMoreData()
}
