//
//  Injection.swift
//  MovieFavorite
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideMovieRepository() -> MovieRepositoryProtocol {
        let realm = try? Realm()
        let local = LocaleDataSource.sharedInstance(realm)
        
        return MovieRepository.sharedInstance(local)
    }
    
    func provideMovieUseCase() -> MovieUseCase {
        let repository = provideMovieRepository()
        return MovieInteractor(repository: repository)
  }

}
