//
//  TMDBSearchMoviesScreenCoordinator.swift
//  Exam
//
//  Created by Carlos Caraccia on 5/16/22.
//

import UIKit

class TMDBSearchMoviesScreenCoordinator:TMDBCoordinatorProtocol  {
    
    var childCoordinators: [TMDBCoordinatorProtocol] = [TMDBCoordinatorProtocol]()
    
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let initialViewController = TMDBSearchMoviesViewController()
        initialViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        initialViewController.coordinator = self
        navigationController.pushViewController(initialViewController, animated: false)
    }
}

