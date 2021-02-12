//
//  MovieFavoriteInteractor.swift
//  MovieFavorite
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import RxSwift

protocol MovieUseCase {
    func getLocalMovies() -> Observable<[MovieModel]>
}

class MovieInteractor: MovieUseCase {
    
    private let repository: MovieRepositoryProtocol
      
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
        
    func getLocalMovies() -> Observable<[MovieModel]> {
        return repository.getLocalMovies()
    }

}
