//
//  MovieFavoriteModel.swift
//  MovieFavorite
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation

struct MovieFavoritePageModel: Equatable {
    let page: Int
    let totalPages: Int
    let movies: [MovieModel]
}

struct MovieModel: Equatable {
    let id: Int
    let title: String?
    let posterURL: String
    let overview: String?
}
