//
//  MovieDetailTransformer.swift
//  MovieDetail
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import Core

extension MovieDetailResponse {
    func toDomain() -> MovieDetailModel {
        return .init(
            id: id,
            title: title,
            posterPath: BuildConfig.imageURL.rawValue + (backdropPath ?? ""),
            overview: overview,
            releaseDate: releaseDate?.formatDate(),
            genres: genres?.map {$0.name} ?? [String](),
            language: language?.map {$0.name} ?? [String](),
            productions: productions?.map {$0.name} ?? [String](),
            year: releaseDate?.formatyear())
    }
}

extension MovieDetailModel {
    func toEntity() -> MovieDetailEntity {
        let entity = MovieDetailEntity()
        entity.id = id
        entity.title = title ?? ""
        entity.posterPath = posterPath ?? ""
        entity.overview = overview ?? ""
        entity.releaseDate = releaseDate ?? ""
        entity.genres.append(objectsIn: genres)
        entity.language.append(objectsIn: language)
        entity.productions.append(objectsIn: productions)
        entity.year = year ?? ""
        return entity
    }
}
