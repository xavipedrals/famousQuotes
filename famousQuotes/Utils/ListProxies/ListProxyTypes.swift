//
//  ListProxyFactory.swift
//  InternetTV
//
//  Created by Xavier Pedrals on 19/10/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ReactiveCell {
    func initCell(from: ParseableObj)
}

class TableViewProxy<ViewModel: BaseListViewModel>: ListProxy {
    
    var listView: UITableView
    var refreshControl: UIRefreshControl?
    var viewModel: ViewModel
    var cellType: UITableViewCell.Type
    let disposeBag = DisposeBag()
    
    init(tableView: UITableView, viewModel: ViewModel, cellType: UITableViewCell.Type) {
        self.listView = tableView
        self.viewModel = viewModel
        self.cellType = cellType
    }
    
    func setupListCells(cellId: String) {
        viewModel.data.asObservable()
            .bind(to: listView.rx.items(cellIdentifier: cellId, cellType: cellType)) { _, data, cell in
                if let data = data as? ParseableObj, let cell = cell as? ReactiveCell {
                    cell.initCell(from: data)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func setupListCells(cellId: String, completion: @escaping (ReactiveCell, Int) -> Void) {
        viewModel.data.asObservable()
            .bind(to: listView.rx.items(cellIdentifier: cellId, cellType: cellType)) { index, data, cell in
                if let data = data as? ParseableObj, let cell = cell as? ReactiveCell {
                    cell.initCell(from: data)
                    completion(cell, index)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func configureRefreshControl(refreshControl: UIRefreshControl) {
        self.refreshControl = refreshControl
        listView.addSubview(refreshControl)
        self.configureRefreshControl()
    }
}

class CollectionViewProxy<ViewModel: BaseListViewModel>: ListProxy {
    
    var listView: UICollectionView
    var viewModel: ViewModel
    var refreshControl: UIRefreshControl?
    var cellType: UICollectionViewCell.Type
    let disposeBag = DisposeBag()
    
    init(collectionView: UICollectionView, viewModel: ViewModel, cellType: UICollectionViewCell.Type) {
        self.listView = collectionView
        self.viewModel = viewModel
        self.cellType = cellType
    }
    
    func setupListCells(cellId: String) {
        viewModel.data.asObservable()
            .bind(to: listView.rx.items(cellIdentifier: cellId, cellType: cellType)) { _, data, cell in
                if let data = data as? ParseableObj, let cell = cell as? ReactiveCell {
                    cell.initCell(from: data)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func configureRefreshControl(refreshControl: UIRefreshControl) {
        self.refreshControl = refreshControl
        listView.addSubview(refreshControl)
        self.configureRefreshControl()
    }
}

extension ListProxy {
    
    func configureLoadMore() {
        listView.rx.contentOffset
            .throttle(0.7, scheduler: MainScheduler.instance)
            .flatMap { _ in
                return self.listView.isNearBottomEdge(edgeOffset: 40.0)
                    ? Observable.just(())
                    : Observable.empty()
            }
            .subscribe(onNext: { _ in
                //TODO: Implement some observable here or in the func
                self.viewModel.getMoreData()
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func configureRefreshControl() {
        self.refreshControl?.rx.controlEvent(.valueChanged)
            .throttle(0.7, scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.viewModel.getData(offset: 0)
            })
            .disposed(by: disposeBag)
        
        self.configureHideRefreshControl()
    }
    
    private func configureHideRefreshControl() {
        viewModel.data.asObservable()
            .subscribe(onNext: {
                self.listView.isHidden = ($0.count == 0)
                if self.refreshControl!.isRefreshing {
                    self.hideTableRefresh()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func hideTableRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700), execute: {
            self.refreshControl?.endRefreshing()
        })
    }
}



