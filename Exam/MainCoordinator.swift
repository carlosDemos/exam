//
//  MainCoordinator.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import Foundation
import UIKit

class MainCoordinator:Coordinator  {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let layout = UICollectionViewFlowLayout()
        let initialViewController = TMDBInitialMoviesController(collectionViewLayout:layout)
        initialViewController.delegate = self
        navigationController.pushViewController(initialViewController, animated: false)
    }
    
    func showDetailedMovieScreen(with movie:Movie) {
        let movieDetailsViewController = DetailedScreenViewController()
        movieDetailsViewController.delegate = self
        self.navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
}
