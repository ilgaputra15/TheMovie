//
//  BaseDataSource.swift
//  TheMovie
//
//  Created by Ilga Putra on 25/11/20.
//

import Foundation
import Moya

protocol BaseAPI: TargetType {}

extension BaseAPI {
    var baseHeaders: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseParam: [String: Any] {
        return ["api_key": BuildConfig.apiKey.rawValue]
    }
    
    var baseUrl: String {
        return BuildConfig.baseURL.rawValue
    }
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return baseHeaders
    }
}

