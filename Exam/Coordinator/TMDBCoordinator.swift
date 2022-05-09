//
//  TMDBCoordinator.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import Foundation
import UIKit

protocol TMDBCoordinator {
    
    var childCoordinators:[TMDBCoordinator] { get set }
    var navigationController:UINavigationController { get set }
    
    func start()
    
}
