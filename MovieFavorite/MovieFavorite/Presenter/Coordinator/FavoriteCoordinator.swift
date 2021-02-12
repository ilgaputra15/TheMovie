//
//  FavoriteCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 01/12/20.
//

import UIKit
import RxSwift
import Core

public class MovieFavoriteCoodinator: BaseCoordinator {
    
    var navTo: ((Int) -> Void)?
    
    public func create(navigation: UINavigationController, navTo: @escaping (Int) -> Void) -> UIViewController {
        self.navTo = navTo
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
        if let navTo = navTo {
            navTo(movieId)
        }
    }
}
