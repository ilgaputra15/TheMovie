//
//  SearchCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 28/11/20.
//

import UIKit

class SearchCoordinator: BaseCoordinator {
        
    func create(navigation: UINavigationController) -> UIViewController {
        let inject = Injection.init().provideMovieUseCase()
        let viewModel = SearchViewModel(homeUseCase: inject, disposeBag: disposeBag)
        let viewController = SearchViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel
        setupBinding(viewModel: viewModel)
        self.navigationController = navigation
        return viewController
    }
    
    func setupBinding(viewModel: SearchViewModel) {
        viewModel.navToDetail.subscribe(onNext: { (movie) in self.navigateToDetail(movieId: movie.id)}).disposed(by: disposeBag)
    }
    
    func navigateToDetail(movieId: Int) {
        let detail = DetailCoordinator(movieId: movieId)
        detail.navigationController = navigationController
        detail.start()
    }
}
