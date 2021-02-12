//
//  DetailCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 29/11/20.
//

import Foundation
import Core

public class MovieDetailCoordinator: BaseCoordinator {
    
    let movieId: Int
    
    public init(movieId: Int) {
        self.movieId = movieId
    }
    
    public override func start() {
        let inject = Injection.init().provideMovieUseCase()
        let viewModel = DetailViewModel(homeUseCase: inject, disposeBag: disposeBag)
        let viewController = DetailViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel
        viewModel.movieId.accept(movieId)
        navigationController.pushViewController(viewController, animated: true)
    }
}
