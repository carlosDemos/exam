//
//  TMDBServiceError.swift
//  Exam
//
//  Created by Carlos Caraccia on 06/05/2022.
//

import Foundation


enum TMDBServiceError:Error {
    
    case serviceError
    case incorrectEndPoint
    case invalidResponse
    case invalidData
    
    var localizedDescrition:String {
        switch self {
            case .serviceError: return "Failied fetching data"
            case .incorrectEndPoint: return "The endpoint is incorrect"
            case .invalidResponse: return "Invalid response"
            case .invalidData: return "The data was invalid"
        }
    }
    
    var errorUserInfo:[String:Any] {
        [NSLocalizedDescriptionKey : localizedDescrition]
    }
}
