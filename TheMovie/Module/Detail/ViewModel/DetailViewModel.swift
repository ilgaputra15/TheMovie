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
    let isFavorite = BehaviorRelay<Bool>(value: false)
    let saveFavorite = PublishRelay<Void>()
    var movieData: MovieDetailModel?
    var id: Int?
    
    
    init(homeUseCase: MovieUseCase, disposeBag: DisposeBag) {
        self.movieUseCase = homeUseCase
        self.disposeBag = disposeBag
        super.init()
        setupBinding()
    }
    
    func setupBinding() {
        movieId.subscribe { (id) in
            self.id = id
        }.disposed(by: disposeBag)
        saveFavorite.subscribe { (_) in
            if let movie = self.movieData {
                if !self.isFavorite.value {
                    self.addFavorite(movie: movie)
                } else {
                    self.deleteFavorite(movieId: movie.id)
                }
            }
        }.disposed(by: disposeBag)
    }
    
    func addFavorite(movie: MovieDetailModel) {
        self.movieUseCase.saveMovie(movie: movie)
            .subscribe { (isSave) in
                if isSave {
                    self.isFavorite.accept(true)
                }
            } onError: { [weak self] (error) in
                self?.stateErrorView.accept(error.localizedDescription)
            }.disposed(by: self.disposeBag)
    }
    
    func deleteFavorite(movieId: Int) {
        self.movieUseCase.deleteMovie(movieId: movieId)
            .subscribe { (isSave) in
                if isSave {
                    self.isFavorite.accept(false)
                }
            } onError: { [weak self] (error) in
                self?.stateErrorView.accept(error.localizedDescription)
            }.disposed(by: self.disposeBag)
    }
    
    func getDetail() {
        self.isLoading.accept(true)
        self.movieUseCase.getMovie(by: id ?? 0)
            .subscribe { [weak self] (movie) in
                if let `self` = self {
                    self.isFavorite.accept(movie.isFromLocal)
                    self.movie.accept(movie)
                    self.movieData = movie
                    self.isLoading.accept(false)
                }
            } onError: { [weak self] (error) in
                self?.stateErrorView.accept(error.localizedDescription)
                self?.isLoading.accept(false)
            }.disposed(by: disposeBag)
    }
    
}
