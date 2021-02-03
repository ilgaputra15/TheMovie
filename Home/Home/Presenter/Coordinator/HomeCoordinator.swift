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
   
    public func create(navigation: UINavigationController) -> UIViewController {
        let interactor = Interactor(repository: HomeRepository(remoteDataSource: HomeRemoteDataSource(), mapper: HomeTransformer()))
        let viewModel = HomeViewModel(homeUseCase: interactor, disposeBag: disposeBag)
        let viewController = HomeViewController()
        viewController.disposeBag = disposeBag
        viewController.viewModel = viewModel
        setupBinding(viewModel: viewModel)
        self.navigationController = navigation
        return viewController
    }
    
    func setupBinding(viewModel: HomeViewModel<Interactor<Any, HomesPageModel, HomeRepository<HomeRemoteDataSource, HomeTransformer>>>) {
        viewModel.navToDetail.subscribe(onNext: { (movie) in self.navigateToDetail(movieId: movie.id)}).disposed(by: disposeBag)
    }
    
    public func navigateToDetail(movieId: Int) {
//        let detail = DetailCoordinator(movieId: movieId)
//        detail.navigationController = navigationController
//        detail.start()
    }
}
