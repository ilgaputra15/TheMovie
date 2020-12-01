//
//  FavoriteViewModel.swift
//  TheMovie
//
//  Created by Ilga Putra on 01/12/20.
//

import Foundation
import RxSwift
import RxRelay

class FavoriteViewModel: BaseViewModel {
    private let movieUseCase: MovieUseCase
    private let disposeBag: DisposeBag
    
    let movies = PublishRelay<[MovieModel]>()
    let stateErrorView = PublishRelay<String>()
    let loading = PublishRelay<Bool>()
    let navToDetail = PublishRelay<MovieModel>()
    
    init(homeUseCase: MovieUseCase, disposeBag: DisposeBag) {
        self.movieUseCase = homeUseCase
        self.disposeBag = disposeBag
        super.init()
    }
    
    func getMovies() {
        loading.accept(true)
        movieUseCase.getLocalMovies().subscribe { [weak self] (movies) in
            self?.movies.accept(movies)
        } onError: { [weak self] (error) in
            self?.stateErrorView.accept(error.localizedDescription)
        } onCompleted: {
            self.loading.accept(false)
        }
        .disposed(by: disposeBag)

    }
}
