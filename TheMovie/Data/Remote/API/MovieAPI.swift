//
//  MovieAPI.swift
//  TheMovie
//
//  Created by Ilga Putra on 25/11/20.
//

import Foundation
import Moya

enum MovieAPI {
    case getMovies
    case searchMovies(query: String)
    case getMovie(movieId: Int)
}

extension MovieAPI: BaseAPI {
    var path: String {
        switch self {
        case .getMovies:
            return "movie/now_playing"
        case .searchMovies:
            return "search/movie"
        case .getMovie(let id):
            return "movie/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovies, .searchMovies, .getMovie:
            return .get
        }
    }
    
    var task: Task {
        var param = baseParam
        switch self {
        case .searchMovies(let query):
            param["query"] = query
        case .getMovies, .getMovie: break
        }
        return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    }
}
