//
//  RemoteDataSource.swift
//  MovieDetail
//
//  Created by Ilga Putra on 03/02/21.
//

import Foundation
import RxSwift
import Moya

protocol RemoteDataSourceProtocol: class {
    func getMovie(by movieId: Int) -> Observable<MovieDetailResponse>
}

final class RemoteDataSource: NSObject {
    private override init() { }
    private var provider = MoyaProvider<MovieDetailAPI>()
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {    
    func getMovie(by movieId: Int) -> Observable<MovieDetailResponse> {
        return self.provider.rx.request(.getMovie(movieId: movieId), MovieDetailResponse.self)
    }
}
