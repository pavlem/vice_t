//
//  MoviesVC.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 25.5.21..
//

import UIKit

class MoviesVC: UIViewController, Storyboarded {
    
    // MARK: - Properties
    @IBOutlet weak var popularMoviewsLbl: UILabel!
    @IBOutlet weak var nowPlayingMoviewsLbl: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setModels()
        setUI()
        fetchMovies()
    }
    
    private var nowPlayingMoviesCVC: MoviesCollectionVC? {
        return self.children.first as? MoviesCollectionVC
    }
    
    private var mostPopularMoviesCVC: MoviesCollectionVC? {
        return self.children.last as? MoviesCollectionVC
    }
    
    // MARK: - Properties
    private var moviesVM = MoviesVM(isLoadingScreenShown: true) {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Helper
    private func fetchMovies() {
        moviesVM.fetch { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .failure(let err):
                print(err)
                AlertHelper.simpleAlert(message: err.errorDescription, vc: self) {
                    self.moviesVM = MoviesVM(isLoadingScreenShown: false)
                }
                
            case .success(let allMovies):
                DispatchQueue.main.async {
                    self.moviesVM = MoviesVM(isLoadingScreenShown: false)
                    self.nowPlayingMoviesCVC?.movies = allMovies.popular
                    self.mostPopularMoviesCVC?.movies = allMovies.nowPlaying
                }
            }
        }
    }
    
    private func setUI() {
        title = moviesVM.moviesTitle
        view.backgroundColor = moviesVM.backgroundColor
        
        popularMoviewsLbl.text = moviesVM.popularMoviesTxt
        nowPlayingMoviewsLbl.text = moviesVM.nowPlayingMoviesTxt
        
        popularMoviewsLbl.font = moviesVM.moviesLblFont
        nowPlayingMoviewsLbl.font = moviesVM.moviesLblFont
        
        popularMoviewsLbl.textColor = moviesVM.moviesLblTextColor
        nowPlayingMoviewsLbl.textColor = moviesVM.moviesLblTextColor
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.moviesVM.isLoadingScreenShown ? BlockingScreen.start(vc: self) : BlockingScreen.stop(vc: self)
        }
    }
    
    private func setModels() {
        moviesVM = MoviesVM(isLoadingScreenShown: true)
    }
}
