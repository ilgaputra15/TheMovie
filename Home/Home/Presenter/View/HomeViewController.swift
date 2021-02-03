//
//  HomeViewController.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import UIKit
import RxSwift
import Core

public class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: HomeViewModel<Interactor<Any, HomesPageModel, HomeRepository<HomeRemoteDataSource, HomeTransformer>>>!
    var disposeBag: DisposeBag!

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    func setupView() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(
            UINib(
                nibName: "MovieViewCell",
                bundle: Bundle(identifier: "Gyosanilla.Home")
            ), forCellWithReuseIdentifier: "MovieViewCell")
        collectionView.rx.modelSelected(HomeModel.self).bind(to: viewModel.navToDetail).disposed(by: disposeBag)
    }
    
    func setupBinding() {
        viewModel.movies.bind(to: collectionView.rx.items(cellIdentifier: "MovieViewCell", cellType: MovieViewCell.self)) { _, movie, cell in
            cell.setView(movie: movie)
        }.disposed(by: disposeBag)
        
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

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            let cellWidth = (width - 44) / 2
            return CGSize(width: cellWidth, height: cellWidth / 0.7)
        }
}
