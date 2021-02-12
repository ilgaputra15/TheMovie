//
//  MovieSearchResponse.swift
//  MovieSearch
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation

struct MoviesResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
    let page: Int
    let totalPages: Int
    let movies: [MovieResponse]
}

struct MovieResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    let id: Int
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
}
