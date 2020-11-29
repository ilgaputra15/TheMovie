//
//  DashboardViewController.swift
//  TheMovie
//
//  Created by Ilga Putra on 28/11/20.
//

import UIKit

class DashboardViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        
        let home = setupTab(vc: HomeCoordinator().create(), imageName: UIImage(named: "Home"), tag: 1)
        let search = setupTab(vc: SearchCoordinator().create(), imageName: UIImage(named: "Search"), tag: 2)
        viewControllers = [home, search]
        
    }
    
    func setupTab(vc: UIViewController, imageName: UIImage?, tag: Int) -> UIViewController {
        vc.tabBarItem = UITabBarItem(title: "", image: imageName, tag: tag)
        return vc
    }

}
