//
//  LocalDataSource.swift
//  MovieFavorite
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import RealmSwift
import RxSwift
import Core

protocol LocaleDataSourceProtocol: class {
    func getMovies() -> Observable<[MovieLocalEntity]>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?

    private init(realm: Realm?) {
      self.realm = realm

    }

    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
      return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getMovies() -> Observable<[MovieLocalEntity]> {
        return Observable<[MovieLocalEntity]>.create { observer in
          if let realm = self.realm {
            let categories: Results<MovieLocalEntity> = {
              realm.objects(MovieLocalEntity.self)
                .sorted(byKeyPath: "id", ascending: true)
            }()
            observer.onNext(categories.toArray(ofType: MovieLocalEntity.self))
            observer.onCompleted()
          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
