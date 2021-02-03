//
//  BaseAPI.swift
//  Core
//
//  Created by Ilga Putra on 02/02/21.
//

import Foundation
import Moya

public protocol BaseAPI: TargetType {}

public extension BaseAPI {
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
