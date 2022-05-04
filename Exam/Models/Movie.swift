//
//  Movie.swift
//  Exam
//
//  Created by Carlos Caraccia on 04/05/2022.
//

import Foundation

struct Movie:Decodable {
    let id:Int?
    let title:String
    let backdropPath:String?
    let posterPath:String
    let overView:String
    let voteAvg:Double
    let voteCount:Int
    let runtime:Int?
}
