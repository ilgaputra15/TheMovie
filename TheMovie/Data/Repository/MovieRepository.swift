//
//  MovieRepository.swift
//  TheMovie
//
//  Created by Ilga Putra on 25/11/20.
//

import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
    func getMovies() -> Observable<MoviesPageModel>
    func searchMovies(by query: String) -> Observable<MoviesPageModel>

}

final class MovieRepository: NSObject {

  typealias MovieInstance = (RemoteDataSource) -> MovieRepository

  fileprivate let remote: RemoteDataSource

  private init(remote: RemoteDataSource) {
    self.remote = remote
  }

  static let sharedInstance: MovieInstance = { remoteRepo in
    return MovieRepository(remote: remoteRepo)
  }

}

extension MovieRepository: MovieRepositoryProtocol {
    func getMovies() -> Observable<MoviesPageModel> {
        return remote.getMovies().map { $0.toDomain() }
    }
    
    func searchMovies(by query: String) -> Observable<MoviesPageModel> {
        return remote.searchMovies(by: query).map { $0.toDomain() }
    }
}
