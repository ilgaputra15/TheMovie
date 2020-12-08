//
//  MovieEntity.swift
//  TheMovie
//
//  Created by Ilga Putra on 30/11/20.
//

import Foundation
import RealmSwift
class MovieEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var year: String = ""
    var genres = List<String>()
    var language = List<String>()
    var productions = List<String>()

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension MovieEntity {
    func toDomain() -> MovieDetailModel {
        return .init(
            isFromLocal: true,
            id: id,
            title: title,
            posterPath: posterPath,
            overview: overview,
            releaseDate: releaseDate,
            genres: toArrayString(from: genres),
            language: toArrayString(from: language),
            productions: toArrayString(from: productions),
            year: year)
    }
    
    func toArrayString(from: List<String>) -> [String] {
        var array = [String]()
        array.append(contentsOf: Array(from))
        return array
        
    }
    
    func toMovieModelDomain() -> MovieModel {
        return .init(
            id: id,
            title: title,
            posterURL: posterPath,
            overview: overview)
    }
}
