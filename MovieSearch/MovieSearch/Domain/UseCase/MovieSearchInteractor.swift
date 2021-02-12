//
//  MovieSearchInteractor.swift
//  MovieSearch
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import RxSwift

public protocol MovieUseCase {
    func searchMovie(by query: String) -> Observable<MovieSearchPageModel>
}

class MovieInteractor: MovieUseCase {
    
    private let repository: MovieSearchRepositoryProtocol
      
    required init(repository: MovieSearchRepositoryProtocol) {
        self.repository = repository
    }
    
    func searchMovie(by query: String) -> Observable<MovieSearchPageModel> {
        return repository.searchMovies(by: query)
    }

}
