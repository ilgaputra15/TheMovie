//
//  DataSource.swift
//  Core
//
//  Created by Ilga Putra on 16/01/21.
//

import Foundation
import RxSwift

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func getMovies() -> Observable<[Response]>
    func addMovie(from movie: Request) -> Observable<Bool>
    func deleteMovie(from movieId: Int) -> Observable<Bool>
    func getMovie(from movieId: Int) -> Observable<Response?>
}
