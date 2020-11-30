//
//  HomeCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    
    func create(navigation: UINavigationController) -> UIViewController {
        let inject = Injection.init().provideMovieUseCase()
        let viewModel = HomeViewModel(homeUseCase: inject, disposeBag: disposeBag)
        let viewController = HomeViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel
        setupBinding(viewModel: viewModel)
        self.navigationController = navigation
        return viewController
    }
    
    func setupBinding(viewModel: HomeViewModel) {
        viewModel.navToDetail.subscribe(onNext: { (movie) in self.navigateToDetail(movieId: movie.id)}).disposed(by: disposeBag)
    }
    
    func navigateToDetail(movieId: Int) {
        let detail = DetailCoordinator(movieId: movieId)
        detail.navigationController = navigationController
        detail.start()
    }
}
