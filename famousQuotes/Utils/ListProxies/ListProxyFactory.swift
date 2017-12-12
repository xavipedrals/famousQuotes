//
//  ListProxy.swift
//  InternetTV
//
//  Created by Xavier Pedrals on 25/10/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import UIKit
import RxSwift

enum ListProxyFactory<T: BaseListViewModel> {
    static func factory(for cv: UICollectionView, viewModel: T, cellType: UICollectionViewCell.Type) -> CollectionViewProxy<T> {
        return CollectionViewProxy(collectionView: cv, viewModel: viewModel, cellType: cellType)
    }
    
    static func factory(for tv: UITableView, viewModel: T, cellType: UITableViewCell.Type) -> TableViewProxy<T> {
        return TableViewProxy(tableView: tv, viewModel: viewModel, cellType: cellType)
    }
}

protocol ListProxy {
    associatedtype ScrollView: UIScrollView
    associatedtype ViewModel: BaseListViewModel
    
    var refreshControl: UIRefreshControl? { get set }
    var listView: ScrollView { get }
    var viewModel: ViewModel { get }
    var disposeBag: DisposeBag { get }
    
    func setupListCells(cellId: String)
    func configureRefreshControl(refreshControl: UIRefreshControl)
}


