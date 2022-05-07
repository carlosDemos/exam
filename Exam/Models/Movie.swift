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
    let overview:String
    let voteAverage:Double
    let voteCount:Int
    let runtime:Int?
}
