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
        let nav = UINavigationController(rootViewController: viewController)
        viewController.viewControllers = tabViewControllers(navigation: nav)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
    func tabViewControllers(navigation: UINavigationController) -> [UIViewController] {
        let home = setupTab(vc: HomeCoordinator().create(navigation: navigation), imageName: UIImage(named: "Home"), tag: 1)
        let search = setupTab(vc: SearchCoordinator().create(navigation: navigation), imageName: UIImage(named: "Search"), tag: 2)
        return [home, search]
        
    }
    
    func setupTab(vc: UIViewController, imageName: UIImage?, tag: Int) -> UIViewController {
        vc.tabBarItem = UITabBarItem(title: "", image: imageName, tag: tag)
        return vc
    }
}
