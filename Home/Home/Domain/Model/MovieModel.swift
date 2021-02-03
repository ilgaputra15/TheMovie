//
//  MovieModel.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import Foundation

public struct HomesPageModel: Equatable {
    let page: Int
    let totalPages: Int
    let movies: [HomeModel]
}

public struct HomeModel: Equatable {
    let id: Int
    let title: String?
    let posterURL: String
    let overview: String?
}
