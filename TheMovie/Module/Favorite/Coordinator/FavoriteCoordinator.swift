//
//  FavoriteCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 01/12/20.
//

import UIKit
import RxSwift

class FavoriteCoodinator: BaseCoordinator {
    func create(navigation: UINavigationController) -> UIViewController {
        let inject = Injection.init().provideMovieUseCase()
        let viewModel = FavoriteViewModel(homeUseCase: inject, disposeBag: disposeBag)
        let viewController = FavoriteViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel
        setupBinding(viewModel: viewModel)
        self.navigationController = navigation
        return viewController
    }
    
    func setupBinding(viewModel: FavoriteViewModel) {
        viewModel.navToDetail.subscribe(onNext: { (movie) in self.navigateToDetail(movieId: movie.id)}).disposed(by: disposeBag)
    }
    
    func navigateToDetail(movieId: Int) {
        let detail = DetailCoordinator(movieId: movieId)
        detail.navigationController = navigationController
        detail.start()
    }
}
