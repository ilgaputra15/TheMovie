//
//  SearchViewModel.swift
//  TheMovie
//
//  Created by Ilga Putra on 28/11/20.
//

import Foundation
import Core
import RxSwift
import RxRelay

public class MovieSearchViewModel: BaseViewModel {
    
    private let movieUseCase: MovieUseCase
    private let disposeBag: DisposeBag
    
    let movies = PublishRelay<[MovieSearchModel]>()
    let stateErrorView = PublishRelay<String>()
    let isLoading = PublishRelay<Bool>()
    let isFirstLoading = BehaviorRelay<Bool>(value: true)
    let search = BehaviorRelay<String>(value: "")
    let navToDetail = PublishRelay<MovieSearchModel>()
    
    public init(homeUseCase: MovieUseCase, disposeBag: DisposeBag) {
        self.movieUseCase = homeUseCase
        self.disposeBag = disposeBag
        setupBinding()
    }
    
    func setupBinding() {
        search
            .filter { $0 != "" }
            .flatMap { (query) -> Observable<MovieSearchPageModel> in
                self.isFirstLoading.accept(false)
                self.isLoading.accept(true)
                return self.movieUseCase.searchMovie(by: query)
            }
            .subscribe { [weak self] (response) in
                if let `self` = self {
                    self.movies.accept(response.movies)
                    self.isLoading.accept(false)
                }
            } onError: { [weak self] (error) in
                self?.stateErrorView.accept(error.localizedDescription)
                self?.isLoading.accept(false)
            }.disposed(by: disposeBag)
    }
}
