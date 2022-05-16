//
//  TMDBInitialScreenCoordinator.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import Foundation
import UIKit

class TMDBInitialScreenCoordinator:TMDBCoordinatorProtocol  {
    
    var childCoordinators: [TMDBCoordinatorProtocol] = [TMDBCoordinatorProtocol]()
    
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let initialViewController = TMDBInitialMoviesController()
        initialViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        initialViewController.delegate = self
        navigationController.pushViewController(initialViewController, animated: false)
    }
    
    func showDetailedMovieScreen(with movie:Movie) {
        let movieDetailsViewController = TMDBDetailedMovieScreen(movieId: movie.id)
        movieDetailsViewController.delegate = self
        self.navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
}
