//
//  Error.swift
//  TheMovie
//
//  Created by Ilga Putra on 01/12/20.
//

import Foundation

public enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
  
    public var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        }
    }
}
