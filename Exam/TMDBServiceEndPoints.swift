//
//  TMDBServiceEndPoints.swift
//  Exam
//
//  Created by Carlos Caraccia on 06/05/2022.
//

import Foundation


enum TMDBServiceEndPoints:String {
    
    case upcomming
    case popular
    case topRated = "top_rated"
    
    var description:String {
        
        switch self {
            case .popular: return "Popular"
            case .topRated: return "Top Rated"
            case .upcomming: return "Upcomming"
        }
    }
}
