//
//  LocalDataSource.swift
//  TheMovie
//
//  Created by Ilga Putra on 30/11/20.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: class {
    func getMovies() -> Observable<[MovieEntity]>
    func addMovie(from movie: MovieEntity) -> Observable<Bool>
    func deleteMovie(from movieId: Int) -> Observable<Bool>
    func getMovie(from movieId: Int) -> Observable<MovieEntity?>
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
    func getMovies() -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create { observer in
          if let realm = self.realm {
            let categories: Results<MovieEntity> = {
              realm.objects(MovieEntity.self)
                .sorted(byKeyPath: "id", ascending: true)
            }()
            observer.onNext(categories.toArray(ofType: MovieEntity.self))
            observer.onCompleted()
          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    
    func addMovie(from movie: MovieEntity) -> Observable<Bool> {
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
                let objectsToDelete = realm.objects(MovieEntity.self).filter("id == \(movieId)")
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
    
    func getMovie(from movieId: Int) -> Observable<MovieEntity?> {
        return Observable<MovieEntity?>.create { observer in
          if let realm = self.realm {
            let movie = realm.objects(MovieEntity.self).filter("id == \(movieId)").first
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

