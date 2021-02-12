//
//  MovieSearchModel.swift
//  MovieSearch
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation

public struct MovieSearchPageModel: Equatable {
    let page: Int
    let totalPages: Int
    let movies: [MovieSearchModel]
}

public struct MovieSearchModel: Equatable {
    let id: Int
    let title: String?
    let posterURL: String
    let overview: String?
}
