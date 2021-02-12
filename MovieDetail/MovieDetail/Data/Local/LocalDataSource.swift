//
//  LocalDataSource.swift
//  MovieDetail
//
//  Created by Ilga Putra on 03/02/21.
//

import Foundation
import RealmSwift
import RxSwift
import Core

protocol LocaleDataSourceProtocol: class {
    func addMovie(from movie: MovieLocalEntity) -> Observable<Bool>
    func deleteMovie(from movieId: Int) -> Observable<Bool>
    func getMovie(from movieId: Int) -> Observable<MovieLocalEntity?>
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
    func addMovie(from movie: MovieLocalEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
          if let realm = self.realm {
            do {
              try realm.write {
                realm.add(movie, update: .all)
                observer.onNext(true)
                observer.onCompleted()
              }
            } catch {
              observer.onError(DatabaseError.requestFailed)
            }

          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    
    func deleteMovie(from movieId: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
          if let realm = self.realm {
            do {
              try realm.write {
                let objectsToDelete = realm.objects(MovieLocalEntity.self).filter("id == \(movieId)")
                realm.delete(objectsToDelete)
                observer.onNext(true)
                observer.onCompleted()
              }
            } catch {
              observer.onError(DatabaseError.requestFailed)
            }

          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    
    func getMovie(from movieId: Int) -> Observable<MovieLocalEntity?> {
        return Observable<MovieLocalEntity?>.create { observer in
          if let realm = self.realm {
            let movie = realm.objects(MovieLocalEntity.self).filter("id == \(movieId)").first
            observer.onNext(movie)
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
