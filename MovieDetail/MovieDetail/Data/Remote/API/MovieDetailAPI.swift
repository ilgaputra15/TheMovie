//
//  MovieDetailAPI.swift
//  MovieDetail
//
//  Created by Ilga Putra on 03/02/21.
//

import Foundation
import Moya
import Core

enum MovieDetailAPI {
    case getMovie(movieId: Int)
}

extension MovieDetailAPI: BaseAPI {
    var path: String {
        switch self {
        case .getMovie(let id):
            return "movie/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovie:
            return .get
        }
    }
    
    var task: Task {
        let param = baseParam
        switch self {
        case .getMovie : break
        }
        return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    }
}
