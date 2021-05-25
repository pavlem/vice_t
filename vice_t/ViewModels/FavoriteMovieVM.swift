//
//  FavoriteMovieVM.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 25.5.21..
//

import UIKit

struct FavoriteMovieVM {
    
    // MARK: - API    
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

    var rating: String {
        return String(voteAverage)
    }
    
    var originalTitleDescription: String {
        return "(\(originalTitle))"
    }
    
    var releaseDateDescription: String {
        return "Releasing on: \(releaseDate)"
    }
    
    var ratingImage: UIImage? {
        return UIImage(named: "starImg")
    }
    
    // other
    let cellHeight = CGFloat(170)
    let isImageRounded = true
    
    let titleLblFont = UIFont.boldSystemFont(ofSize: 16)
    let originalTitleLblFont = UIFont.boldSystemFont(ofSize: 13)
    let releaseDateLblFont = UIFont.systemFont(ofSize: 13)
    let ratingLblFont = UIFont.systemFont(ofSize: 12)

    let titleLblTextColor = UIColor.themeColor
    let originalTitleLblTextColor = UIColor.lightGray
    let releaseDateTextColor = UIColor.white
    let ratingLblTextColor = UIColor.white
    
    let backgroundColor = UIColor.backgroundColor1
    let seperatorColor = UIColor.lightGray
}

extension FavoriteMovieVM {
    init(movie: Movie) {
        title = movie.title
        originalTitle = movie.originalTitle
        id = movie.id
        originalLanguage = movie.originalLanguage
        overview = movie.overview
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        voteCount = movie.voteCount
        genreIds = movie.genreIds
        posterUrl = movie.posterUrl
        genres = movie.genres
    }
}
