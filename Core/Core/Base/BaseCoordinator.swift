//
//  BaseCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import Foundation
import UIKit
import RxSwift

public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }

    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func removeChildCoordinators()
    func didCloseView(_ animated: Bool)
}

open class BaseCoordinator: Coordinator {
    public var navigationController = UINavigationController()
    public var childCoordinators = [Coordinator]()
    public var parentCoordinator: Coordinator?
    public let disposeBag = DisposeBag()
    
    public init() {
    }

    public func start() {
        fatalError("Start method should be implemented.")
    }

    public func start(coordinator: Coordinator) {
        self.childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.start()
    }

    public func removeChildCoordinators() {
        self.childCoordinators.forEach { $0.removeChildCoordinators() }
        self.childCoordinators.removeAll()
    }

    public func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
    
    public func didCloseView(_ animated: Bool = true) {}
}
