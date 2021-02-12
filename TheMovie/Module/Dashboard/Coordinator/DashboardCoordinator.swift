//
//  DashboardCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 28/11/20.
//

import UIKit
import Home
import MovieDetail
import MovieSearch
import MovieFavorite

class DashboardCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let viewController = DashboardViewController()
        let nav = UINavigationController(rootViewController: viewController)
        navigationController = nav
        viewController.viewControllers = tabViewControllers(navigation: nav)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
    func tabViewControllers(navigation: UINavigationController) -> [UIViewController] {
        let homeVC = HomeCoordinator().create(navigation: navigation) { movieId in
            self.navToMovieDetail(movieId: movieId)
        }
        let searchCoor = MovieSearchCoordinator().create(navigation: navigation) { movieId in
            self.navToMovieDetail(movieId: movieId)
        }
        
        let favoriteCoor = MovieFavoriteCoodinator().create(navigation: navigation) { movieId in
            self.navToMovieDetail(movieId: movieId)
        }
        let home = setupTab(vc: homeVC, imageName: UIImage(named: "Home"), tag: 1)
        let search = setupTab(vc: searchCoor, imageName: UIImage(named: "Search"), tag: 2)
        let favorite = setupTab(vc: favoriteCoor, imageName: UIImage(named: "Favorite"), tag: 3)
        let profile = setupTab(vc: ProfileCoordinator().create(navigation: navigation), imageName: UIImage(named: "Profile"), tag: 4)
        return [home, search, favorite, profile]
        
    }
    
    func navToMovieDetail(movieId: Int) {
        let detail = MovieDetailCoordinator(movieId: movieId)
        detail.navigationController = navigationController
        detail.start()
    }
    
    func setupTab(vc: UIViewController, imageName: UIImage?, tag: Int) -> UIViewController {
        vc.tabBarItem = UITabBarItem(title: "", image: imageName, tag: tag)
        return vc
    }
}
