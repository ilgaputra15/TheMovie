//
//  MovieSearchRepository.swift
//  MovieSearch
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import RxSwift

protocol MovieSearchRepositoryProtocol {
    func searchMovies(by query: String) -> Observable<MovieSearchPageModel>
}

final class MovieSearchRepository: NSObject {

    typealias MovieInstance = (RemoteDataSource) -> MovieSearchRepository

    fileprivate let remote: RemoteDataSource

    private init(remote: RemoteDataSource) {
        self.remote = remote
    }

    static let sharedInstance: MovieInstance = { remoteRepo in
        return MovieSearchRepository(remote: remoteRepo)
    }
}

extension MovieSearchRepository: MovieSearchRepositoryProtocol {
    func searchMovies(by query: String) -> Observable<MovieSearchPageModel> {
        return remote.searchMovies(by: query).map { $0.toDomain() }
    }
}
