//
//  DefaultCollectionView.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 12/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol DefaultCollectionView {
    func setupCollectionViewCells()
    func observeCollectionClicks()
    func setCollectionDelegate()
    func configureLoadMore()
    func configureRefreshControl()
}

extension DefaultCollectionView {
    
    func setupCollectionView() {
        setupCollectionViewCells()
        observeCollectionClicks()
        setCollectionDelegate()
        configureLoadMore()
        configureRefreshControl()
    }
    
    //viewWidth is needed for iPhoneX
    func getCellSize(viewWidth: CGFloat, sideInset: CGFloat, cellsPerRow: Int, cellSpacing: CGFloat, heightProportion: CGFloat) -> CGSize {
        let fCellsPerRow = CGFloat(cellsPerRow)
        let emptySpace = (sideInset * 2) + ((fCellsPerRow - 1) * cellSpacing)
        let cellWidth = (viewWidth - emptySpace) / fCellsPerRow
        let cellHeight = cellWidth * heightProportion
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
