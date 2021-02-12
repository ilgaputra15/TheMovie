//
//  Injection.swift
//  Home
//
//  Created by Ilga Putra on 13/02/21.
//

import Foundation
import Core

final class Injection: NSObject {
    
    private func provideHomeRepository() -> HomeRepository<HomeRemoteDataSource, HomeTransformer> {
        let remote = HomeRemoteDataSource()
        let mapper = HomeTransformer()
        return HomeRepository(remoteDataSource: remote, mapper: mapper)
    }
    
    func provideMovieUseCase() -> Interactor<Any, HomesPageModel, HomeRepository<HomeRemoteDataSource, HomeTransformer>> {
        return Interactor(repository: provideHomeRepository())
  }

}
