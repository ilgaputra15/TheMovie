//
//  DetailViewModel.swift
//  TheMovie
//
//  Created by Ilga Putra on 29/11/20.
//

import Foundation
import RxSwift
import RxRelay

class DetailViewModel: BaseViewModel {
    
    private let movieUseCase: MovieUseCase
    private let disposeBag: DisposeBag
    
    let stateErrorView = PublishRelay<String>()
    let isLoading = PublishRelay<Bool>()
    let movieId = PublishRelay<Int>()
    let movie = PublishRelay<MovieDetailModel>()
    
    init(homeUseCase: MovieUseCase, disposeBag: DisposeBag) {
        self.movieUseCase = homeUseCase
        self.disposeBag = disposeBag
        super.init()
        setupBinding()
    }
    
    func setupBinding() {
        movieId.flatMap { (id) -> Observable<MovieDetailModel> in
            self.isLoading.accept(true)
            return self.movieUseCase.getMovie(by: id)
        }.subscribe { [weak self] (movie) in
            if let `self` = self {
                self.movie.accept(movie)
                self.isLoading.accept(false)
            }
        } onError: { [weak self] (error) in
            self?.stateErrorView.accept(error.localizedDescription)
            self?.isLoading.accept(false)
        }.disposed(by: disposeBag)

    }
}
