//
//  vice_tTests.swift
//  vice_tTests
//
//  Created by Pavle Mijatovic on 24.5.21..
//

import XCTest
@testable import vice_t

class vice_tTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchFavoriteMovies() {

        getMoviesVM { moviesVM in
            let movieDetailsVM = moviesVM.map { MovieDetailVM(movieVM: $0, posterImage: nil) }
            let movies = movieDetailsVM.map { Movie(movieDetailVM: $0) }
            let favMoviesVM = movies.map { FavoriteMovieVM(movie: $0) }
            
            let favoritesCollectionVM = FavoritesCollectionVM()
            let searchArr1 = favoritesCollectionVM.filter(favoriteMovies: favMoviesVM, searchText: "Mortal")
            
            let searchArr2 = favoritesCollectionVM.filter(favoriteMovies: favMoviesVM, searchText: "Mo")
            
            let searchArr3 = favoritesCollectionVM.filter(favoriteMovies: favMoviesVM, searchText: "2021-03")

            XCTAssert(searchArr1.count == 1)
            XCTAssert(searchArr2.count == 4)
            XCTAssert(searchArr3.count == 5)
        }
    }
    
    func testAllVMsMappings() {
        getMoviesVM { moviesVM in
            let movieDetailsVM = moviesVM.map { MovieDetailVM(movieVM: $0, posterImage: nil) }
            let movies = movieDetailsVM.map { Movie(movieDetailVM: $0) }
            let favMoviesVM = movies.map { FavoriteMovieVM(movie: $0) }
            XCTAssert(movieDetailsVM.count == moviesVM.count)
            XCTAssert(movies.count == movieDetailsVM.count)
            XCTAssert(favMoviesVM.count == movies.count)
            print("")
        }
    }
    
    func testFavoriteMovieVM() {
        getMovieVM { movieVM in
            let movieDetailVM = MovieDetailVM(movieVM: movieVM, posterImage: nil)
            let movie = Movie(movieDetailVM: movieDetailVM)
            let favMovieVM = FavoriteMovieVM(movie: movie)
            
            XCTAssert(favMovieVM.title == movie.title)
            XCTAssert(favMovieVM.originalTitle == movie.originalTitle)
            XCTAssert(favMovieVM.id == movie.id)
            XCTAssert(favMovieVM.originalLanguage == movie.originalLanguage)
            XCTAssert(favMovieVM.overview == movie.overview)
            XCTAssert(favMovieVM.releaseDate == movie.releaseDate)
            XCTAssert(favMovieVM.voteAverage == movie.voteAverage)
            XCTAssert(favMovieVM.voteCount == movie.voteCount)
            XCTAssert(favMovieVM.genreIds == movie.genreIds)
            XCTAssert(favMovieVM.posterUrl == movie.posterUrl)
            XCTAssert(favMovieVM.rating == String(movie.voteAverage))
            XCTAssert(favMovieVM.originalTitleDescription == "(\(movie.originalTitle))")
            XCTAssert(favMovieVM.releaseDateDescription == "Releasing on: \(movie.releaseDate)")
        }
    }
    
    func testMovie() {
        getMovieVM { movieVM in
            let movieDetailVM = MovieDetailVM(movieVM: movieVM, posterImage: nil)
            let movie = Movie(movieDetailVM: movieDetailVM)
            
            XCTAssert(movie.title == movieDetailVM.title)
            XCTAssert(movie.originalTitle == movieDetailVM.originalTitle)
            XCTAssert(movie.id == movieDetailVM.id)
            XCTAssert(movie.originalLanguage == movieDetailVM.originalLanguage)
            XCTAssert(movie.overview == movieDetailVM.overview)
            XCTAssert(movie.releaseDate == movieDetailVM.releaseDate)
            XCTAssert(movie.voteAverage == movieDetailVM.voteAverage)
            XCTAssert(movie.voteCount == movieDetailVM.voteCount)
            XCTAssert(movie.genreIds == movieDetailVM.genreIds)
            XCTAssert(movie.posterUrl == movieDetailVM.posterUrl)
        }
    }
    
    func testMovieDetailVM() {
        getMovieVM { movie in
            let movieDetailVM = MovieDetailVM(movieVM: movie, posterImage: nil)
            
            XCTAssert(movieDetailVM.title == movie.title)
            XCTAssert(movieDetailVM.originalTitle == movie.originalTitle)
            XCTAssert(movieDetailVM.id == movie.id)
            XCTAssert(movieDetailVM.originalLanguage == movie.originalLanguage)
            XCTAssert(movieDetailVM.overview == movie.overview)
            XCTAssert(movieDetailVM.releaseDate == movie.releaseDate)
            XCTAssert(movieDetailVM.voteAverage == movie.voteAverage)
            XCTAssert(movieDetailVM.voteCount == movie.voteCount)
            XCTAssert(movieDetailVM.genreIds == movie.genreIds)
            XCTAssert(movieDetailVM.posterUrl == movie.posterUrl)
            XCTAssert(movieDetailVM.rating == movie.rating)
            XCTAssert(movieDetailVM.releaseDateDescription == "Release date: 2021-03-31")
            XCTAssert(movieDetailVM.ratingDescription == "7.2 from 500 votes")
            XCTAssert(movieDetailVM.originalTitleDescription == "Original title: The Unholy")
            XCTAssert(movieDetailVM.posterImage == nil)
        }
    }
    
    func testMovieVM() {
        
        getMovieVM { movie in
            XCTAssert(movie.title == "The Unholy")
            XCTAssert(movie.originalTitle == "The Unholy")
            XCTAssert(movie.originalLanguage == "en")
            XCTAssert(movie.overview == "Alice, a young hearing-impaired girl who, after a supposed visitation from the Virgin Mary, is inexplicably able to hear, speak and heal the sick. As word spreads and people from near and far flock to witness her miracles, a disgraced journalist hoping to revive his career visits the small New England town to investigate. When terrifying events begin to happen all around, he starts to question if these phenomena are the works of the Virgin Mary or something much more sinister.")
            XCTAssert(movie.popularity == 3681.658)
            XCTAssert(movie.posterPath == "/b4gYVcl8pParX8AjkN90iQrWrWO.jpg")
            XCTAssert(movie.releaseDate == "2021-03-31")
            XCTAssert(movie.video == false)
            XCTAssert(movie.voteAverage == 7.2)
            XCTAssert(movie.voteCount == 500)
            XCTAssert(movie.posterUrl == "www.vice123.com/b4gYVcl8pParX8AjkN90iQrWrWO.jpg")
            XCTAssert(movie.rating == "7.2")
        }
    }
    
    func getMoviesVM(completion: @escaping ([MovieVM]) -> Void) {
        
        let asyncExpectation = expectation(description: "Async block executed")
        
        vice_tTests.fetchMOCNowPlayingMovies { (moviesVMs) in
            completion(moviesVMs)
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func getMovieVM(completion: @escaping (MovieVM) -> Void) {
        
        let asyncExpectation = expectation(description: "Async block executed")
        
        vice_tTests.fetchMOCNowPlayingMovies { (moviesVMs) in
            completion(moviesVMs.first!)
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchNowPlayingMoviesFromJSONResponse() {
        let asyncExpectation = expectation(description: "Async block executed")
        
        vice_tTests.fetchMOCNowPlayingMovies { (moviesVMs) in
            XCTAssert(moviesVMs.count == 20)
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchPopularMoviesFromJSONResponse() {
        let asyncExpectation = expectation(description: "Async block executed")
        
        vice_tTests.fetchMOCNowPlayingMovies { (moviesVMs) in
            XCTAssert(moviesVMs.count == 20)
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    static func fetchMOCNowPlayingMovies(delay: Int = 0, completion: @escaping ([MovieVM]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            let filePath = "nowPlayingMOC"
            loadJsonDataFromFile(filePath, completion: { data in
                if let json = data {
                    do {
                        
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let moviesResponseDictionary = try jsonDecoder.decode(MoviesResponseDictionary.self, from: json)
                        let moviesVMs = moviesResponseDictionary.results.map { MovieVM(movieResponse: $0, imagePath: "www.vice123.com") }
                        completion(moviesVMs)
                    } catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            })
        }
    }
    
    static func fetchMOCPopularMovies(delay: Int = 0, completion: @escaping ([MovieVM]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            let filePath = "popularMoviesMOC"
            loadJsonDataFromFile(filePath, completion: { data in
                if let json = data {
                    do {
                        
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let moviesResponseDictionary = try jsonDecoder.decode(MoviesResponseDictionary.self, from: json)
                        let moviesVMs = moviesResponseDictionary.results.map { MovieVM(movieResponse: $0, imagePath: "www.vice1234.com") }
                        completion(moviesVMs)
                    } catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            })
        }
    }
    
    static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data as Data)
            } catch {
                completion(nil)
            }
        }
    }
}
