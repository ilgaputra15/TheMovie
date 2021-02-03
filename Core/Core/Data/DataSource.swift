//
//  DataSource.swift
//  Core
//
//  Created by Ilga Putra on 02/02/21.
//

import Foundation
import RxSwift

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
