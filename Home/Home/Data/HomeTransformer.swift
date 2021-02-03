//
//  HomeTransformer.swift
//  Home
//
//  Created by Ilga Putra on 02/02/21.
//

import Foundation
import Core

struct HomeTransformer: Mapper {
    typealias Response = HomesResponse
    typealias Entity = HomesResponse
    typealias Domain = HomesPageModel
    
    func transformResponseToEntity(response: HomesResponse) -> HomesResponse {
        return response
    }
    
    func transformEntityToDomain(entity: HomesResponse) -> HomesPageModel {
        return entity.toDomain()
    }
}

extension HomeResponse {
    func toDomain() -> HomeModel {
        return .init(
            id: id,
            title: title,
            posterURL: BuildConfig.imageURL.rawValue + (posterPath ?? ""),
            overview: overview
        )
    }
}

extension HomesResponse {
    func toDomain() -> HomesPageModel {
        return .init(
            page: page, totalPages: totalPages, movies: movies.map {$0.toDomain() }
        )
    }
}
