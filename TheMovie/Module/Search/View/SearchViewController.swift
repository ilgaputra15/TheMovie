//
//  SearchViewController.swift
//  TheMovie
//
//  Created by Ilga Putra on 28/11/20.
//

import UIKit
import RxSwift

class SearchViewController: BaseViewController {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var noResultLabel: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var disposeBag: DisposeBag!
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    func setupView() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieViewCell")
        collectionView.rx.modelSelected(MovieModel.self).bind(to: viewModel.navToDetail).disposed(by: disposeBag)
    }
    
    func setupBinding() {
        searchBar.rx.text.orEmpty
            .filter { query in return query.count > 2 }
            .debounce(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.search).disposed(by: disposeBag)
        
        viewModel.movies.bind(to: collectionView.rx.items(cellIdentifier: "MovieViewCell", cellType: MovieViewCell.self)) {row, movie, cell in
            cell.setView(movie: movie)
        }.disposed(by: disposeBag)
        
        viewModel.isLoading.map{!$0}.bind(to: loading.rx.isHidden).disposed(by: disposeBag)
        viewModel.movies.map{!$0.isEmpty}.bind(to: noResultLabel.rx.isHidden).disposed(by: disposeBag)
        viewModel.stateErrorView.subscribe(onNext: {[weak self] error in
            self?.hideLoadingDialog {
                self?.errorAlert(message: error)
            }
        }).disposed(by: disposeBag)
        viewModel.isFirstLoading.map{!$0}.bind(to: descLabel.rx.isHidden).disposed(by: disposeBag)
        
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 44) / 2
        return CGSize(width: cellWidth, height: cellWidth / 0.7)
    }
}
