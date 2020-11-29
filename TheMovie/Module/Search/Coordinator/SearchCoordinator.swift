//
//  SearchCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 28/11/20.
//

import UIKit

class SearchCoordinator: BaseCoordinator {
        
    func create() -> UIViewController {
        let inject = Injection.init().provideMovieUseCase()
        let viewModel = SearchViewModel(homeUseCase: inject, disposeBag: disposeBag)
        let viewController = SearchViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel
        return viewController
    }
}
