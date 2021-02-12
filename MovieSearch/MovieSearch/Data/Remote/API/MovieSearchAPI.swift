//
//  MovieSearchAPI.swift
//  MovieSearch
//
//  Created by Ilga Putra on 12/02/21.
//

import Foundation
import Moya
import Core

enum MovieSearchAPI {
    case searchMovies(query: String)
}

extension MovieSearchAPI: BaseAPI {
    var path: String {
        switch self {
        case .searchMovies:
            return "search/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchMovies:
            return .get
        }
    }
    
    var task: Task {
        var param = baseParam
        switch self {
        case .searchMovies(let query):
            param["query"] = query
        }
        return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    }
}
