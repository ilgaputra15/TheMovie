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
    func searchMovie(by query: String) -> Observable<MoviesPageModel>
    func getMovie(by movieId: Int) -> Observable<MovieDetailModel>
    func saveMovie(movie: MovieDetailModel) -> Observable<Bool>
    func deleteMovie(movieId: Int) -> Observable<Bool>
}

class MovieInteractor: MovieUseCase {
    
    private let repository: MovieRepositoryProtocol
      
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
        
    func getMovies() -> Observable<MoviesPageModel> {
        return repository.getMovies()
    }
    
    func searchMovie(by query: String) -> Observable<MoviesPageModel> {
        return repository.searchMovies(by: query)
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
