//
//  MovieAPI.swift
//  TheMovie
//
//  Created by Ilga Putra on 25/11/20.
//

import Foundation
import Moya

enum MovieAPI {
    case getMovie
}

extension MovieAPI: BaseAPI {
    var path: String {
        switch self {
        case .getMovie:
            return "movie/now_playing"
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
        return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    }
}
