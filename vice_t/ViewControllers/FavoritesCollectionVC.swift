//
//  FavoritesCVC.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 25.5.21..
//

import UIKit

class FavoritesCollectionVC: UICollectionViewController, Storyboarded {

    // MARK: - Properties
    private var vm = FavoritesCollectionVM()
        
    private var movies = [FavoriteMovieVM]()
    private var filteredMovies = [FavoriteMovieVM]() {
        didSet {
            DispatchQueue.main.async {
                self.refreshUI()
            }
        }
    }

    // Search realted
    private let searchController = UISearchController(searchResultsController: nil)
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
        
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchController()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadFavoriteMovies()
    }
    
    // MARK: - Helper
    private func refreshUI() {
        collectionView.reloadData()
    }
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = vm.searchPlaceholder
        searchController.searchBar.keyboardAppearance = .dark
        definesPresentationContext = true
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeColor]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setUI() {
        title = vm.title
        collectionView.backgroundColor = vm.backgroundColor
    }
    
    private func loadFavoriteMovies() {
        vm.loadFavoriteMovies { favMovies in
            guard let favMovies = favMovies else { return }
            movies = favMovies
            collectionView.reloadData()
        }
    }
    
    private func filter(searchText: String) {
        filteredMovies = vm.filter(favoriteMovies: movies, searchText: searchText)
    }
}

// MARK: UICollectionViewDelegate
extension FavoritesCollectionVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        var favMovieVM: FavoriteMovieVM

        if isFiltering {
            favMovieVM = filteredMovies[indexPath.row]
        } else {
            favMovieVM = movies[indexPath.row]
        }
        
        let movieDetailVM = MovieDetailVM(favoriteMovieVM: favMovieVM, posterImage: nil)
        let vc = MovieDetailsVC.instantiate()
        vc.movieDetailVM = movieDetailVM
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension FavoritesCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let vm = movies[indexPath.row]
        return CGSize(width: self.view.frame.size.width, height: vm.cellHeight)
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesCollectionVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredMovies.count
        } else {
            return movies.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCell.id, for: indexPath) as? FavoritesCell else { return UICollectionViewCell() }
        
        
        var vm: FavoriteMovieVM

        if isFiltering {
            vm = filteredMovies[indexPath.row]
        } else {
            vm = movies[indexPath.row]
        }

        cell.vm = vm
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension FavoritesCollectionVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filter(searchText: searchController.searchBar.text!)
    }
}
