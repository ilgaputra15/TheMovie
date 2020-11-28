//
//  AppCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let coordinator = HomeCoordinator(window: window)
        coordinator.start()
    }
}
