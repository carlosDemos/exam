//
//  TMDBSearchMoviesViewController.swift
//  Exam
//
//  Created by Carlos Caraccia on 5/16/22.
//

import UIKit

class TMDBSearchMoviesViewController:UIViewController {
    
    weak var coordinator:TMDBSearchMoviesScreenCoordinator?
    
    // TODO: add a table view in here where we can display all the movies through a search. Also handle the search on and off line with the cache policy.
    
    lazy var notImplementedLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .light)
        label.text = "Not yet implemented"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(notImplementedLabel)
        
        NSLayoutConstraint.activate([
            notImplementedLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            notImplementedLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
