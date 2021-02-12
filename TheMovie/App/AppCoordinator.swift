//
//  AppCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import UIKit
import Core

class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let coordinator = DashboardCoordinator(window: window)
        coordinator.start()
    }
}
