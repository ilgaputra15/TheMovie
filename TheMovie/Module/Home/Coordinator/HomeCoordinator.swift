//
//  HomeCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let inject = Injection.init().provideMovieUseCase()
        let viewModel = HomeViewModel(homeUseCase: inject, disposeBag: disposeBag)
        let viewController = HomeViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel
        
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
