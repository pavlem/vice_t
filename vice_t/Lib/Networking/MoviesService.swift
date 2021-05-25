//
//  CatalogService.swift
//  vice_t
//
//   Created by Pavle Mijatovic on 24.5.21..
//

import UIKit



class MoviesService: NetworkService {
    
    // MARK: - API
    func fetch(image imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) -> URLSessionDataTask? {

        guard let url = URL(string: imageUrl) else { return nil }

        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in

            if let err = err {
                completion(.failure(NetworkError.error(err: err)))
                return
            }

            guard let data = data else {
                completion(.failure(.unknown))
                return
            }

            guard let img = UIImage(data: data) else {
                completion(.failure(.unknown))
                return
            }

            completion(.success(img))
        }
        task.resume()
        return task
    }

    func fetchNowPlayingMovies(moviesRequest: MoviesRequest, completion: @escaping (Result<MoviesResponseDictionary?, NetworkError>) -> ()) -> URLSessionDataTask? {

        return load(urlString: urlString, path: pathNowPlaying, method: .get, params: moviesRequest.body(), headers: nil) { (result: Result<MoviesResponseDictionary?, NetworkError>) in

            switch result {
            case .success(let catalogResponse):
                completion(.success(catalogResponse))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func fetchPopularMovies(moviesRequest: MoviesRequest?, completion: @escaping (Result<MoviesResponseDictionary?, NetworkError>) -> ()) -> URLSessionDataTask? {

        return load(urlString: urlString, path: pathPopular, method: .get, params: moviesRequest?.body(), headers: nil) { (result: Result<MoviesResponseDictionary?, NetworkError>) in

            switch result {
            case .success(let catalogResponse):
                completion(.success(catalogResponse))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func fetchMovie(movieId: String, moviesRequest: MoviesRequest?, completion: @escaping (Result<MovieDetailsResponse?, NetworkError>) -> ()) -> URLSessionDataTask? {

        return load(urlString: urlString, path: pathMovieDetails + movieId, method: .get, params: moviesRequest?.body(), headers: nil) { (result: Result<MovieDetailsResponse?, NetworkError>) in

            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    // MARK: - Properties
    private let scheme = "https://"
    private let host = "api.themoviedb.org/"
    private let pathNowPlaying = "3/movie/now_playing"
    private let pathPopular = "3/movie/popular"
    private let pathMovieDetails = "3/movie/"

    private var urlString: String {
        return scheme + host
    }
}
