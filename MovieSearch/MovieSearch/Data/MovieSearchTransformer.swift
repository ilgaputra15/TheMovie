//
//  MovieSearchTransformer.swift
//  MovieSearch
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import Core

extension MovieResponse {
    func toDomain() -> MovieSearchModel {
        return .init(
            id: id,
            title: title,
            posterURL: BuildConfig.imageURL.rawValue + (posterPath ?? ""),
            overview: overview
        )
    }
}

extension MoviesResponse {
    func toDomain() -> MovieSearchPageModel {
        return .init(
            page: page, totalPages: totalPages, movies: movies.map {$0.toDomain() }
        )
    }
}
