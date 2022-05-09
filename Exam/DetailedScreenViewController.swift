//
//  DetailedScreenViewController.swift
//  Exam
//
//  Created by Carlos Caraccia on 04/05/2022.
//

import UIKit


class DetailedScreenViewController: UIViewController  {
    
    weak var delegate:MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
}

