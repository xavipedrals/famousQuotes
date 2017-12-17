//
//  ViewController.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 12/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RecentViewController: UIViewController, DefaultCollectionView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    let quoteDetailSegueId = "goToQuoteDetail"
    var collectionViewProxy: CollectionViewProxy<RecentViewModel>?
    var selectedElement: Quote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewProxy = ListProxyFactory.factory(for: collectionView, viewModel: RecentViewModel(), cellType: QuoteCollectionViewCell.self)
        setupCollectionView()
        setupNavBar()
        configNavigationBar()
    }
    
    func setupNavBar() {
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    func configNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupCollectionViewCells() {
        collectionViewProxy!.setupListCells(cellId: "quoteCell")
    }
    
    func observeCollectionClicks() {
        collectionView.rx.modelSelected(Quote.self)
            .subscribe(onNext: { quote in
                self.selectedElement = quote
                self.performSegue(withIdentifier: self.quoteDetailSegueId, sender: nil)
            })
            .disposed(by: disposeBag)
    }
    
    func setCollectionDelegate() {
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func configureLoadMore() {
        
    }
    
    func configureRefreshControl() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == quoteDetailSegueId {
            let vc = segue.destination as! QuoteDetailViewController
            vc.quote = selectedElement
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("Haalou")
        collectionView.collectionViewLayout.invalidateLayout()
    }

}

extension RecentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        var cellsPerRow = 1
        if screenWidth > 414 && screenWidth < 900 { //ipad size
            cellsPerRow = 2
        }
        else if screenWidth > 900 { //ipad horizontal
            cellsPerRow = 3
        }
        return self.getCellSize(viewWidth: collectionView.bounds.width, sideInset: 10, cellsPerRow: cellsPerRow, cellSpacing: 0, heightProportion: 1.2)
    }
}

