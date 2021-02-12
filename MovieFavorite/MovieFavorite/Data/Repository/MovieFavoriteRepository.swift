//
//  MovieFavoriteRepository.swift
//  MovieFavorite
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
    func getLocalMovies() -> Observable<[MovieModel]>
}

final class MovieRepository: NSObject {

    typealias MovieInstance = (LocaleDataSource) -> MovieRepository

    fileprivate let local: LocaleDataSource  

    private init(local: LocaleDataSource) {
        self.local = local
    }

    static let sharedInstance: MovieInstance = { localRepo in
        return MovieRepository(local: localRepo)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    func getLocalMovies() -> Observable<[MovieModel]> {
        return local.getMovies().map { $0.map {$0.toMovieModelDomain()} }
    }
}
