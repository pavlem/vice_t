//
//  Movie.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 28.5.21..
//

import Foundation

struct Movie: Codable {
    let title: String
    let originalTitle: String
    let id: Int
    let originalLanguage: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let genreIds: [Int]
    let posterUrl: String
    let genres: String
}

extension Movie {
    init(movieDetailVM: MovieDetailVM) {
        self.title = movieDetailVM.title
        self.originalTitle = movieDetailVM.originalTitle
        self.id = movieDetailVM.id
        self.originalLanguage = movieDetailVM.originalLanguage
        self.overview = movieDetailVM.overview
        self.releaseDate = movieDetailVM.releaseDate
        self.voteAverage = movieDetailVM.voteAverage
        self.voteCount = movieDetailVM.voteCount
        self.genreIds = movieDetailVM.genreIds
        self.posterUrl = movieDetailVM.posterUrl
        self.genres = movieDetailVM.genresDescription
    }
}
