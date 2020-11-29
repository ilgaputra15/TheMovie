//
//  RemoteDataSource.swift
//  TheMovie
//
//  Created by Ilga Putra on 25/11/20.
//

import Foundation
import RxSwift
import Moya

protocol RemoteDataSourceProtocol: class {
    func getMovies() -> Observable<MoviesResponse>
    func searchMovies(by query: String) -> Observable<MoviesResponse>
}

final class RemoteDataSource: NSObject {
    private override init() { }
    private var provider = MoyaProvider<MovieAPI>()
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getMovies() -> Observable<MoviesResponse> {
        return self.provider.rx.request(.getMovies, MoviesResponse.self)
    }
    
    func searchMovies(by query: String) -> Observable<MoviesResponse> {
        return self.provider.rx.request(.searchMovies(query: query), MoviesResponse.self)
    }
    
    
}


