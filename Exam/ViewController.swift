//
//  ViewController.swift
//  Exam
//
//  Created by Carlos Caraccia on 04/05/2022.
//

import UIKit

class ViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        let presenter = TMDBInitialScreenPresenter(webService: TMDBNetworkingService(),
                                                   delegate: self)
        presenter.getInitialMovies()
    }
}

extension ViewController: TMDBInitialScreenViewDelegateProtocol {
    
    func successfulGetInitialMovies(moviesDictionary: [TMDBServiceEndPoints : [Movie]]) {
        print(moviesDictionary)
    }
    
    func errorHandler(error: TMDBServiceError) {
        print(error)
    }

}

