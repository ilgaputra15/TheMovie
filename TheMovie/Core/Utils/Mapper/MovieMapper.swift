//
//  MovieMapper.swift
//  TheMovie
//
//  Created by Ilga Putra on 08/12/20.
//

import Foundation

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

extension MovieResponse {
    func toDomain() -> MovieModel {
        return .init(
            id: id,
            title: title,
            posterURL: BuildConfig.imageURL.rawValue + (posterPath ?? ""),
            overview: overview
        )
    }
}

extension MoviesResponse {
    func toDomain() -> MoviesPageModel {
        return .init(
            page: page, totalPages: totalPages, movies: movies.map {$0.toDomain() }
        )
    }
}

extension MovieDetailModel {
    func toEntity() -> MovieEntity {
        let entity = MovieEntity()
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
