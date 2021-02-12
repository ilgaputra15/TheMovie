//
//  MovieDetailModel.swift
//  MovieDetail
//
//  Created by Ilga Putra on 03/02/21.
//

import Foundation

public struct MovieDetailModel {
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
