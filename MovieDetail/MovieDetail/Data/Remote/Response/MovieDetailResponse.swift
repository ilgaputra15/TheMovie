//
//  MovieDetailResponse.swift
//  MovieDetail
//
//  Created by Ilga Putra on 03/02/21.
//

import Foundation
struct MovieDetailResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case genres
        case language = "spoken_languages"
        case productions = "production_companies"
    }
    let id: Int
    let title: String?
    let backdropPath: String?
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
