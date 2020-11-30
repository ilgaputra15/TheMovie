//
//  DetailCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 29/11/20.
//

import Foundation

class DetailCoordinator: BaseCoordinator {
    
    let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    override func start() {
        let inject = Injection.init().provideMovieUseCase()
        let viewModel = DetailViewModel(homeUseCase: inject, disposeBag: disposeBag)
        let viewController = DetailViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel
        viewModel.movieId.accept(movieId)
        navigationController.pushViewController(viewController, animated: true)
        
    }
}
