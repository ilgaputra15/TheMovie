//
//  HomeViewModel.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel: BaseViewModel {
    
    private let movieUseCase: MovieUseCase
    private let disposeBag: DisposeBag
    
    let movies = PublishRelay<[MovieModel]>()
    let stateErrorView = PublishRelay<String>()
    let loading = PublishRelay<Bool>()
    
    init(homeUseCase: MovieUseCase, disposeBag: DisposeBag) {
        self.movieUseCase = homeUseCase
        self.disposeBag = disposeBag
        super.init()
        self.getMovies()
    }
    
    func getMovies() {
        loading.accept(true)
        movieUseCase.getMovies().subscribe { [weak self] (movies) in
            self?.movies.accept(movies.movies)
        } onError: { [weak self] (error) in
            self?.stateErrorView.accept(error.localizedDescription)
        } onCompleted: {
            self.loading.accept(false)
        }
        .disposed(by: disposeBag)

    }
}
