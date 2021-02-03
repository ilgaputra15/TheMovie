//
//  HomeRemoteDataSource.swift
//  Home
//
//  Created by Ilga Putra on 17/01/21.
//

import Foundation
import Core
import RxSwift
import Moya

public struct HomeRemoteDataSource: DataSource {
    public typealias Request = Any
    public typealias Response = HomesResponse
    
    private var provider = MoyaProvider<HomeAPI>()
    static let sharedInstance: HomeRemoteDataSource =  HomeRemoteDataSource()
    
    public func execute(request: Any?) -> Observable<HomesResponse> {
        return self.provider.rx.request(.getMovies, HomesResponse.self)
    }
    
    
    
    
}
