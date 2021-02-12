//
//  MovieEntity.swift
//  Core
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import RealmSwift
public class MovieLocalEntity: Object {
    @objc public dynamic var id: Int = 0
    @objc public dynamic var title: String = ""
    @objc public dynamic var posterPath: String = ""
    @objc public dynamic var overview: String = ""
    @objc public dynamic var releaseDate: String = ""
    @objc public dynamic var year: String = ""
    public var genres = List<String>()
    public var language = List<String>()
    public var productions = List<String>()

    public override static func primaryKey() -> String? {
        return "id"
    }
}

extension MovieLocalEntity {
    public func toArrayString(from: List<String>) -> [String] {
        var array = [String]()
        array.append(contentsOf: Array(from))
        return array
        
    }
}
