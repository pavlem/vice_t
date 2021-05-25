//
//  MovieDetailVM.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 27.5.21..
//

import UIKit

struct MovieDetailVM {
    
    // MARK: - API
    func setPosterImageOverlayView(frame: CGRect, toView view: UIView) {
        let imageOverlayView = UIView(frame: frame)
        imageOverlayView.backgroundColor = .black
        imageOverlayView.alpha = 0.6
        view.addSubview(imageOverlayView)
    }
    
    // MARK: - Properties
    // codable
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
    
    // other
    let posterImage: UIImage?
    
    var ratingImage: UIImage? {
        return UIImage(named: "starImg")
    }
    
    let backgroundColor = UIColor.backgroundColor1
    let saveButtonBackgroundColor = UIColor.themeColor
    
    let titleFont = UIFont.boldSystemFont(ofSize: 30)
    let lblFont = UIFont.boldSystemFont(ofSize: 18)
    let descriptionFont = UIFont.systemFont(ofSize: 18)
    
    let titleTextColor = UIColor.themeColor
    let otherTextColor = UIColor.white
    
    var releaseDateDescription: String {
        return "Release date: " + releaseDate
    }
    
    var rating: String {
        return String(voteAverage)
    }
    
    var ratingDescription: String {
        return rating + " from " + String(voteCount) + " votes"
    }
    
    var originalTitleDescription: String {
        return "Original title: " + originalTitle
    }
    
    var genres = ""
    var genresDescription: String {
        return "Genres: " + genres
    }
    
    // Network
    // MARK: - Properties
    private var dataTask: URLSessionDataTask?
    private let moviesService = MoviesService()
    
    func cancelCatalogsFetch() {
        dataTask?.cancel()
    }
    
    mutating func fetchGenres(completion: @escaping (Result<([String]), NetworkError>) -> Void) {
        
        dataTask = moviesService.fetchMovie(movieId: String(self.id), moviesRequest: MoviesRequest(page: nil), completion: { result in
            
            switch result {
            case .failure(let err):
                completion(.failure(err))
                print(err)
            case .success(let response):
                guard let genres = response?.genres else { return }
                let genresArray = genres.map { $0.name }
                completion(.success(genresArray))
            }
        })
    }
    
    private func getGenresArray(response: MovieDetailsResponse?) -> [String]? {
        guard let genres = response?.genres else { return nil}
        return genres.map { $0.name }
    }
    
    // Persistance
    func loadPersistedMovies(success: ([Movie]) -> Void, fail: () -> Void) {
        UserDefaultsHelper.shared.loadPersistedMovies { movies in
            success(movies)
        } fail: {
            fail()
        }
    }
    
    func isMovieInDB(completion: (Bool) -> Void) {
        
        loadPersistedMovies { movies in
            let isMovieInDB = movies.filter ({ $0.id == id }).count > 0
            completion(isMovieInDB)
        } fail: {
            completion(false)
        }
    }
    
    func remove(movieDetailVM: MovieDetailVM) {
        
        let movie = Movie(movieDetailVM: movieDetailVM)

        loadPersistedMovies { movies in
            var moviesLocal = movies
            moviesLocal.removeAll{ $0.id == movie.id }
            let encoder = JSONEncoder()
            let data = try? encoder.encode(moviesLocal)
            UserDefaultsHelper.shared.movies = data
        } fail: {
            
        }
    }
    
    func persist(movieDetailVM: MovieDetailVM) {

        let movie = Movie(movieDetailVM: movieDetailVM)
    
        loadPersistedMovies { movies in
            var moviesLocal = movies
            
            if moviesLocal.filter({ $0.id == movie.id }).count == 0 {
                moviesLocal.append(movie)
                let encoder = JSONEncoder()
                let data = try? encoder.encode(moviesLocal)
                UserDefaultsHelper.shared.movies = data
            }
            
        } fail: {
            let movies = [movie]
            let encoder = JSONEncoder()
            let data = try? encoder.encode(movies)
            UserDefaultsHelper.shared.movies = data
        }
    }
}

// MARK: - Init
extension MovieDetailVM {
    init(movieVM: MovieVM, posterImage: UIImage?) {
        title = movieVM.title
        originalTitle = movieVM.originalTitle
        id = movieVM.id
        originalLanguage = movieVM.originalLanguage
        overview = movieVM.overview
        releaseDate = movieVM.releaseDate
        voteAverage = movieVM.voteAverage
        voteCount = movieVM.voteCount
        genreIds = movieVM.genreIds
        posterUrl = movieVM.posterUrl
        self.posterImage = posterImage
    }
    
    init(favoriteMovieVM: FavoriteMovieVM, posterImage: UIImage?) {
        title = favoriteMovieVM.title
        originalTitle = favoriteMovieVM.originalTitle
        id = favoriteMovieVM.id
        originalLanguage = favoriteMovieVM.originalLanguage
        overview = favoriteMovieVM.overview
        releaseDate = favoriteMovieVM.releaseDate
        voteAverage = favoriteMovieVM.voteAverage
        voteCount = favoriteMovieVM.voteCount
        genreIds = favoriteMovieVM.genreIds
        posterUrl = favoriteMovieVM.posterUrl
        genres = favoriteMovieVM.genres
        self.posterImage = posterImage
    }
}
