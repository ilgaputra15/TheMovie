//
//  Injection.swift
//  MovieSearch
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation

final class Injection: NSObject {
    
    private func provideMovieSearchRepository() -> MovieSearchRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        return MovieSearchRepository.sharedInstance(remote)
    }
    
    func provideMovieUseCase() -> MovieUseCase {
        let repository = provideMovieSearchRepository()
        return MovieInteractor(repository: repository)
  }

}
