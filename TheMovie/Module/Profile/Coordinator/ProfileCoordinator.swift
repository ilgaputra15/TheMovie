//
//  ProfileCoordinator.swift
//  TheMovie
//
//  Created by Ilga Putra on 01/12/20.
//

import UIKit

class ProfileCoordinator: BaseCoordinator {
    func create(navigation: UINavigationController) -> UIViewController {
        let viewController = ProfileViewController()
        self.navigationController = navigation
        return viewController
    }
}
