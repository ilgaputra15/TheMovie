//
//  Injection.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideMovieRepository() -> MovieRepositoryProtocol {
        let realm = try? Realm()
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let local = LocaleDataSource.sharedInstance(realm)
        
        return MovieRepository.sharedInstance(remote, local)
    }
    
    func provideMovieUseCase() -> MovieUseCase {
        let repository = provideMovieRepository()
        return MovieInteractor(repository: repository)
  }

}
