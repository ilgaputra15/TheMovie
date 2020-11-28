//
//  MovieUseCase.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import Foundation
import RxSwift

protocol MovieUseCase {

  func getMovies() -> Observable<MoviesPageModel>

}

class MovieInteractor: MovieUseCase {
    
    private let repository: MovieRepositoryProtocol
      
    required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
    }
        
    func getMovies() -> Observable<MoviesPageModel> {
        return repository.getMovies()
    }

}
