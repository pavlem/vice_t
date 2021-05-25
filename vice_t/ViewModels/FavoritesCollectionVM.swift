//
//  FavoritesCollectionVM.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 28.5.21..
//

import UIKit

struct FavoritesCollectionVM {
    
    // MARK: - API
    func loadFavoriteMovies(success: ([FavoriteMovieVM]?) -> Void) {
        UserDefaultsHelper.shared.loadPersistedMovies { movies in
            var favMovies = movies.map { FavoriteMovieVM(movie: $0)}
            favMovies = favMovies.sorted(by: { m1, m2 in
                return m1.title < m2.title
            })
            
            success(favMovies)
            
        } fail: {
            success(nil)
        }
    }
    
    func filter(favoriteMovies: [FavoriteMovieVM], searchText: String) -> [FavoriteMovieVM] {
        let filtered = favoriteMovies.filter { (favMovieVM: FavoriteMovieVM) -> Bool in
            return
                favMovieVM.title.lowercased().contains(searchText.lowercased()) ||
                favMovieVM.originalTitleDescription.lowercased().contains(searchText.lowercased()) ||
                favMovieVM.releaseDateDescription.lowercased().contains(searchText.lowercased()) ||
                favMovieVM.rating.lowercased().contains(searchText.lowercased()) ||
                favMovieVM.genres.lowercased().contains(searchText.lowercased())
        }
        return filtered
    }
    
    let backgroundColor = UIColor.backgroundColor1
    let title = "Favourite Movies"
    let searchPlaceholder = "Search for movie..."
}
