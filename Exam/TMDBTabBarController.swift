//
//  TMDBTabBarController.swift
//  Exam
//
//  Created by Carlos Caraccia on 5/16/22.
//

import UIKit

class TMDBTabBarController:UITabBarController {
    
    // initialize all the coordinators that we have asociated which each tab
    let initialScreenCoordinator = TMDBInitialScreenCoordinator(navigationController: UINavigationController())
    let searchMoviesScreenCoordinator = TMDBSearchMoviesScreenCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        initialScreenCoordinator.start()
        searchMoviesScreenCoordinator.start()
        viewControllers = [initialScreenCoordinator.navigationController,
                           searchMoviesScreenCoordinator.navigationController]
    }
    
    
    
}
