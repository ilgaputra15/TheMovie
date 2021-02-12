//
//  SearchCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 28/11/20.
//

import UIKit
import Core

public class MovieSearchCoordinator: BaseCoordinator {
    
    var navTo: ((Int) -> Void)?
        
    public func create(navigation: UINavigationController, navTo: @escaping (Int) -> Void) -> UIViewController {
        self.navTo = navTo
        let inject = Injection.init().provideMovieUseCase()
        let viewModel = MovieSearchViewModel(homeUseCase: inject, disposeBag: disposeBag)
        let viewController = SearchViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel
        setupBinding(viewModel: viewModel)
        self.navigationController = navigation
        return viewController
    }
    
    func setupBinding(viewModel: MovieSearchViewModel) {
        viewModel.navToDetail.subscribe(onNext: { (movie) in self.navigateToDetail(movieId: movie.id)}).disposed(by: disposeBag)
    }
    
    func navigateToDetail(movieId: Int) {
        if let navTo = navTo {
            navTo(movieId)
        }
    }
}
