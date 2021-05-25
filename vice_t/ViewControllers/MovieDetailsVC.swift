//
//  MovieDetailVC.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 27.5.21..
//

import UIKit

class MovieDetailsVC: UIViewController, Storyboarded {

    // MARK: - API
    var movieDetailVM: MovieDetailVM? {
        willSet {
            DispatchQueue.main.async {
                self.updateUI(movieDetailVM: newValue)
            }
        }
    }
    
    // MARK: - Properties
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleOriginalLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var genresLbl: UILabel!

    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var imagePosterImageView: MovieImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var saveBtn: SaveButton!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailVM?.fetchGenres(completion: { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .failure(let err):
                print(err)
            case .success(let arr):
                let stringRepresentation = arr.joined(separator: ", ")
                var movieDetailVM = self.movieDetailVM
                movieDetailVM?.genres = stringRepresentation
                self.movieDetailVM = movieDetailVM
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        movieDetailVM?.cancelCatalogsFetch()
    }
    
    // MARK: - Actions
    @IBAction func saveToFavorites(_ sender: SaveButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            movieDetailVM?.persist(movieDetailVM: movieDetailVM!)
        } else {
            movieDetailVM?.remove(movieDetailVM: movieDetailVM!)
        }
    }
    
    // MARK: - Helper
    private func setUI() {
        view.layoutSubviews()
        movieDetailVM?.setPosterImageOverlayView(frame: imagePosterImageView.frame, toView: imagePosterImageView)
        
        movieDetailVM!.isMovieInDB(completion: { isMovieInDB in
            saveBtn.isSelected = isMovieInDB
        })
    }
    
    private func updateUI(movieDetailVM: MovieDetailVM?) {
        guard let vm = movieDetailVM else { return }
        
        view.backgroundColor = vm.backgroundColor
        saveBtn.color = vm.saveButtonBackgroundColor
        ratingImageView.image = vm.ratingImage
        
        if let image = vm.posterImage {
            imagePosterImageView.image = image
        } else {
            imagePosterImageView.vm = MovieImageVM(imageUrlString: vm.posterUrl)
        }
        
        imagePosterImageView.contentMode = .scaleAspectFill
        
        titleLbl.font = vm.titleFont
        titleOriginalLbl.font = vm.lblFont
        releaseDateLbl.font = vm.lblFont
        ratingLbl.font = vm.lblFont
        genresLbl.font = vm.lblFont
        overviewTextView.font = vm.descriptionFont
        
        titleLbl.textColor = vm.titleTextColor
        titleOriginalLbl.textColor = vm.otherTextColor
        releaseDateLbl.textColor = vm.otherTextColor
        ratingLbl.textColor = vm.otherTextColor
        genresLbl.textColor = vm.otherTextColor
        overviewTextView.textColor = vm.otherTextColor
        
        title = vm.title
        titleLbl.text = title
        titleOriginalLbl.text = vm.originalTitleDescription
        releaseDateLbl.text = vm.releaseDateDescription
        ratingLbl.text = vm.ratingDescription
        releaseDateLbl.text = vm.releaseDateDescription
        genresLbl.text = vm.genresDescription
        overviewTextView.text = vm.overview
    }
}
