//
//  MovieFavoriteTransformer.swift
//  MovieFavorite
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import Core

extension MovieLocalEntity {
    func toMovieModelDomain() -> MovieModel {
        return .init(
            id: id,
            title: title,
            posterURL: posterPath,
            overview: overview)
    }
}
