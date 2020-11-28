//
//  MovieResponse.swift
//  TheMovie
//
//  Created by Ilga Putra on 25/11/20.
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

extension MoviesResponse {
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
}

extension MoviesResponse.MovieResponse {
    func toDomain() -> MovieModel {
        return .init(
            id: id,
            title: title,
            posterPath: posterPath,
            posterURL: BuildConfig.imageURL.rawValue + (posterPath ?? ""),
            overview: overview,
            releaseDate: dateFormatter.date(from: releaseDate ?? "")
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

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
