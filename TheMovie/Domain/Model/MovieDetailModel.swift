//
//  MovieDetailModel.swift
//  TheMovie
//
//  Created by Ilga Putra on 29/11/20.
//

import Foundation

struct MovieDetailModel {
    var isFromLocal: Bool = false
    let id: Int
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let genres: [String]
    let language: [String]
    let productions: [String]
    let year: String?
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
