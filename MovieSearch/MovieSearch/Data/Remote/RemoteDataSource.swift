//
//  RemoteDataSource.swift
//  MovieSearch
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import RxSwift
import Moya

protocol RemoteDataSourceProtocol: class {
    func searchMovies(by query: String) -> Observable<MoviesResponse>
}

final class RemoteDataSource: NSObject {
    private override init() { }
    private var provider = MoyaProvider<MovieSearchAPI>()
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func searchMovies(by query: String) -> Observable<MoviesResponse> {
        return self.provider.rx.request(.searchMovies(query: query), MoviesResponse.self)
    }
}
