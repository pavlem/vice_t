//
//  MovieVM.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 25.5.21..
//

import UIKit

struct MovieVM {
    
    let title: String
    let originalTitle: String
    let id: Int
    let originalLanguage: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let genreIds: [Int]
    let posterUrl: String
    
    var rating: String {
        return String(voteAverage)
    }
    
    // UI setup
    let movieTitleLblFont = UIFont.boldSystemFont(ofSize: 14)
    let ratingLblFont = UIFont.systemFont(ofSize: 10)
    let maxNumberOfLines = 2
    let cornerRadius = CGFloat(10)
    let posterPaddingDown = CGFloat(100)
    let posterPaddingBothSides = CGFloat(16)
    let movieTitlePaddingBothSides = CGFloat(32)

    let movieTxtColor = UIColor.lightGray
    let ratingTxtColor = UIColor.white

    let backgroundColor = UIColor.backgroundColor1
    let containerBackgroundColor = UIColor.backgroundColor2

    var placeHolderImage: UIImage? {
        return UIImage(named: "demoImg")
    }
    
    var ratingImage: UIImage? {
        return UIImage(named: "starImg")
    }
}

extension MovieVM {
    init(movieResponse: MovieResponse, imagePath: String) {
        self.title = movieResponse.title
        self.originalTitle = movieResponse.originalTitle
        self.id = movieResponse.id
        self.originalLanguage = movieResponse.originalLanguage
        self.overview = movieResponse.overview
        self.popularity = movieResponse.popularity
        self.posterPath = movieResponse.posterPath
        self.releaseDate = movieResponse.releaseDate
        self.video = movieResponse.video
        self.voteAverage = movieResponse.voteAverage
        self.voteCount = movieResponse.voteCount
        self.genreIds = movieResponse.genreIds
        self.posterUrl = imagePath + movieResponse.posterPath
    }
}
