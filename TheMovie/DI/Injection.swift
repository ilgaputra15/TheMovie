//
//  Injection.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import Foundation

final class Injection: NSObject {
    
    private func provideMovieRepository() -> MovieRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        return MovieRepository.sharedInstance(remote)
    }
    
    func provideMovieUseCase() -> MovieUseCase {
        let repository = provideMovieRepository()
        return MovieInteractor(repository: repository)
  }

}
