//
//  MovieResponse.swift
//  TheMovie
//
//  Created by Ilga Putra on 25/11/20.
//

import Foundation

public struct HomesResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
    let page: Int
    let totalPages: Int
    let movies: [HomeResponse]
}

public struct HomeResponse: Codable {
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
