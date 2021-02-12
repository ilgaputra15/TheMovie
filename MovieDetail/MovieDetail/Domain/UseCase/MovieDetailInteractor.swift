//
//  MovieDetailInteractor.swift
//  MovieDetail
//
//  Created by Ilga Putra on 03/02/21.
//

import Foundation
import RxSwift

public protocol MovieUseCase {
    func getMovie(by movieId: Int) -> Observable<MovieDetailModel>
    func saveMovie(movie: MovieDetailModel) -> Observable<Bool>
    func deleteMovie(movieId: Int) -> Observable<Bool>
}

class MovieInteractor: MovieUseCase {
    
    private let repository: MovieRepositoryProtocol
      
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovie(by movieId: Int) -> Observable<MovieDetailModel> {
        return repository.getMovie(by: movieId)
    }
    
    func saveMovie(movie: MovieDetailModel) -> Observable<Bool> {
        return repository.saveMovie(movie: movie)
    }
    
    func deleteMovie(movieId: Int) -> Observable<Bool> {
        return repository.deleteMovie(movieId: movieId)
    }
}
