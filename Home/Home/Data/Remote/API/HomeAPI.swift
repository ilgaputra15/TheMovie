//
//  HomeAPI.swift
//  Home
//
//  Created by Ilga Putra on 02/02/21.
//

import Foundation
import Moya
import Core

enum HomeAPI {
    case getMovies
}

extension HomeAPI: BaseAPI {
    var path: String {
        switch self {
        case .getMovies:
            return "movie/now_playing"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovies:
            return .get
        }
    }
    
    var task: Task {
        let param = baseParam
        switch self {
        case .getMovies : break
        }
        return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    }
}
