//
//  DashboardCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 28/11/20.
//

import UIKit

class DashboardCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let viewController = DashboardViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
