//
//  MovieDetailResponse + Mapper.swift
//  TheMovie
//
//  Created by Ilga Putra on 29/11/20.
//

import Foundation

struct MovieDetailResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case genres
        case language = "spoken_languages"
        case productions = "production_companies"
    }
    let id: Int
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let genres: [MovieGenreResponse]?
    let language: [MovieLanguageResponse]?
    let productions: [MovieProductionResponse]?
    
}

extension MovieDetailResponse {
    struct MovieGenreResponse: Codable {
        let name: String
    }

    struct MovieLanguageResponse: Codable {
        let name: String
    }

    struct MovieProductionResponse: Codable {
        let name: String
    }
}

extension MovieDetailResponse {
    func toDomain() -> MovieDetailModel {
        return .init(
            id: id,
            title: title,
            posterPath: BuildConfig.imageURL.rawValue + (posterPath ?? ""),
            overview: overview,
            releaseDate: releaseDate?.formatDate(),
            genres: genres?.map {$0.name},
            language: language?.map {$0.name},
            productions: productions?.map {$0.name},
            year: releaseDate?.formatyear())
    }
}
