//
//  HomeCoordinator.swift
//  Home
//
//  Created by Ilga Putra on 02/02/21.
//

import UIKit
import Core
import RxSwift

public class HomeCoordinator: BaseCoordinator {
    
    var navTo: ((Int) -> Void)?
   
    public func create(navigation: UINavigationController, navTo: @escaping (Int) -> Void) -> UIViewController {
        let useCase = Injection().provideMovieUseCase()
        let viewModel = HomeViewModel(homeUseCase: useCase, disposeBag: disposeBag)
        let viewController = HomeViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel
        self.navTo = navTo
        setupBinding(viewModel: viewModel)
        self.navigationController = navigation
        return viewController
    }
    
    func setupBinding(viewModel: HomeViewModel<Interactor<Any, HomesPageModel, HomeRepository<HomeRemoteDataSource, HomeTransformer>>>) {
        viewModel.navToDetail.subscribe(onNext: { (movie) in self.navigateToDetail(movieId: movie.id)}).disposed(by: disposeBag)
    }
    
    public func navigateToDetail(movieId: Int) {
        if let navTo = navTo {
            navTo(movieId)
        }
//        let detail = DetailCoordinator(movieId: movieId)
//        detail.navigationController = navigationController
//        detail.start()
    }
}
