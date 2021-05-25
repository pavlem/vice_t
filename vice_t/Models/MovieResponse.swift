//
//  MovieResponse.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 27.5.21..
//

import Foundation

struct MovieResponse: Decodable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let genreIds: [Int]
}

struct MovieDetailsResponse: Decodable {
    let homepage: String
    let genres: [MovieDetailsResponseGenre]
}

struct MovieDetailsResponseGenre: Decodable {
    let id: Int
    let name: String
}
