//
//  MoviesResponseDictionary.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 27.5.21..
//

import Foundation

struct MoviesResponseDictionary: Decodable {
    let page: Int
    let results: [MovieResponse]
}
