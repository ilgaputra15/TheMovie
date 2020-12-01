//
//  MovieModel.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import Foundation

struct MoviesPageModel: Equatable {
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

