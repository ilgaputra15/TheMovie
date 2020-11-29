//
//  HomeCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    
    func create() -> UIViewController {
        let inject = Injection.init().provideMovieUseCase()
        let viewModel = HomeViewModel(homeUseCase: inject, disposeBag: disposeBag)
        let viewController = HomeViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel        
        return viewController
    }
}
