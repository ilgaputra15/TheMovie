//
//  HomeRepository.swift
//  Home
//
//  Created by Ilga Putra on 17/01/21.
//

import Foundation
import RxSwift
import Core

protocol HomeRepositoryProtocol {
    func getMovies() -> Observable<HomesPageModel>
}

final class HomeRepository<
    HomeRemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    HomeRemoteDataSource.Request == Any,
    HomeRemoteDataSource.Response == HomesResponse,
    Transformer.Domain == HomesPageModel,
    Transformer.Entity == HomesResponse,
    Transformer.Response == HomesResponse {
    
    typealias Request = Any
    typealias Response = HomesPageModel
    
    private let _remoteDataSource: HomeRemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: HomeRemoteDataSource,
        mapper: Transformer) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    func execute(request: Any?) -> Observable<HomesPageModel> {
        return _remoteDataSource.execute(request: nil).map { self._mapper.transformEntityToDomain(entity:$0) }
    }
    
}
