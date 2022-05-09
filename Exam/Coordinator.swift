//
//  Coordinator.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var childCoordinators:[Coordinator] { get set }
    var navigationController:UINavigationController { get set }
    
    func start()
    
}
