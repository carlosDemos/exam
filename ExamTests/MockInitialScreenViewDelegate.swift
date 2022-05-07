//
//  MockInitialScreenViewDelegate.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 07/05/2022.
//

import Foundation
import XCTest
@testable import Exam

class MockInitialScreenViewDelegate:TMDBInitialScreenViewDelegateProtocol {
    
    var expectation:XCTestExpectation?
    
    func successfulGetInitialImages() {
        expectation?.fulfill()
    }
    
    func errorHandler(error: TMDBServiceError) {
        // TODO: handle the error message in testing
    }

    
}
