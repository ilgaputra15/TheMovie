//
//  MovieDetailRepository.swift
//  MovieDetail
//
//  Created by Ilga Putra on 03/02/21.
//

import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
    func getMovie(by movieId: Int) -> Observable<MovieDetailModel>
    func saveMovie(movie: MovieDetailModel) -> Observable<Bool>
    func deleteMovie(movieId: Int) -> Observable<Bool>
}

final class MovieRepository: NSObject {

    typealias MovieInstance = (RemoteDataSource, LocaleDataSource) -> MovieRepository

    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocaleDataSource

    private init(remote: RemoteDataSource, local: LocaleDataSource) {
        self.remote = remote
        self.local = local
    }

    static let sharedInstance: MovieInstance = { remoteRepo, localRepo in
        return MovieRepository(remote: remoteRepo, local: localRepo)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    
    func getMovie(by movieId: Int) -> Observable<MovieDetailModel> {
        return self.local.getMovie(from: movieId)
            .flatMap({ (movie) -> Observable<MovieDetailModel> in
                guard let movie = movie else {
                    return self.remote.getMovie(by: movieId).map {$0.toDomain() }
                }
                return Observable<MovieDetailModel>.create { sub in
                    sub.onNext(movie.toDomain())
                    return Disposables.create()
                }
            })
    }
    
    func saveMovie(movie: MovieDetailModel) -> Observable<Bool> {
        return local.addMovie(from: movie.toEntity())
    }
    
    func deleteMovie(movieId: Int) -> Observable<Bool> {
        return local.deleteMovie(from: movieId)
    }   
}
