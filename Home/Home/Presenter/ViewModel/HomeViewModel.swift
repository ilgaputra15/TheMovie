//
//  HomeViewModel.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import Foundation
import RxSwift
import RxRelay
import Core

public class HomeViewModel<HomeUseCase: UseCase>: BaseViewModel
where HomeUseCase.Request == Any, HomeUseCase.Response == HomesPageModel {
    
    private let movieUseCase: HomeUseCase
    private let disposeBag: DisposeBag
    
    let movies = PublishRelay<[HomeModel]>()
    let stateErrorView = PublishRelay<String>()
    let loading = PublishRelay<Bool>()
    let navToDetail = PublishRelay<HomeModel>()
    
    public init(homeUseCase: HomeUseCase, disposeBag: DisposeBag) {
        self.movieUseCase = homeUseCase
        self.disposeBag = disposeBag
        self.getMovies()
    }
    
    public func getMovies() {
        loading.accept(true)
        movieUseCase.execute(request: nil).subscribe { [weak self] (movies) in
            self?.movies.accept(movies.movies)
        } onError: { [weak self] (error) in
            self?.stateErrorView.accept(error.localizedDescription)
        } onCompleted: {
            self.loading.accept(false)
        }
        .disposed(by: disposeBag)

    }
}
