//
//  FavoriteViewController.swift
//  TheMovie
//
//  Created by Ilga Putra on 01/12/20.
//

import UIKit
import RxSwift
import Core

class FavoriteViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descLabel: UILabel!
    var viewModel: FavoriteViewModel!
    var disposeBag: DisposeBag!
    
    init() {
        super.init(nibName: "FavoriteViewController", bundle: Bundle(for: FavoriteViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getMovies()
    }
    
    func setupView() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(
            UINib(
                nibName: "MovieViewCell",
                bundle: Bundle(identifier: "Gyosanilla.MovieFavorite")
            ),
            forCellWithReuseIdentifier: "MovieViewCell")
        collectionView.rx.modelSelected(MovieModel.self).bind(to: viewModel.navToDetail).disposed(by: disposeBag)
    }
    
    func setupBinding() {
        viewModel.movies.bind(to: collectionView.rx.items(cellIdentifier: "MovieViewCell", cellType: MovieViewCell.self)) { _, movie, cell in
            cell.setView(movie: movie)
        }.disposed(by: disposeBag)
        viewModel.movies.map { !$0.isEmpty }.bind(to: descLabel.rx.isHidden).disposed(by: disposeBag)
        viewModel.loading.subscribe(onNext: { [weak self] isShow in
            if isShow {
                self?.showLoadingDialog()
            } else {
                self?.hideLoadingDialog()
            }
        }).disposed(by: disposeBag)
        
        viewModel.stateErrorView.subscribe(onNext: {[weak self] error in
            self?.hideLoadingDialog {
                self?.errorAlert(message: error)
            }
        }).disposed(by: disposeBag)
        
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 44) / 2
        return CGSize(width: cellWidth, height: cellWidth / 0.7)
    }
}
