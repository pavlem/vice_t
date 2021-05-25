//
//  MoviesCell.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 25.5.21..
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    
    // MARK: - API
    static let id = "FavoritesCell"
    
    var vm: FavoriteMovieVM? {
        willSet {
            updateUI(vm: newValue)
        }
    }
    
    // MARK: - Properties
    @IBOutlet weak var movieImageView: MovieImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var originalTitleLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var genresLbl: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var cellSeperatorView: UIView!
    @IBOutlet weak var lablesStackWidth: NSLayoutConstraint!
    
    // MARK: - Helper
    private func updateUI(vm: FavoriteMovieVM?) {
        guard let vm = vm else { return }
        
        titleLbl.text = vm.title
        originalTitleLbl.text = vm.originalTitleDescription
        releaseDateLbl.text = vm.releaseDateDescription
        ratingLbl.text = vm.rating
        genresLbl.text = vm.genres
        ratingImageView.image = vm.ratingImage
        
        let movieImageVM = MovieImageVM(imageUrlString: vm.posterUrl)
        movieImageVM.isRounded = vm.isImageRounded
        movieImageView.vm = movieImageVM

        titleLbl.font = vm.titleLblFont
        originalTitleLbl.font = vm.originalTitleLblFont
        releaseDateLbl.font = vm.releaseDateLblFont
        ratingLbl.font = vm.ratingLblFont
        genresLbl.font = vm.releaseDateLblFont

        titleLbl.textColor = vm.titleLblTextColor
        originalTitleLbl.textColor = vm.originalTitleLblTextColor
        releaseDateLbl.textColor = vm.releaseDateTextColor
        ratingLbl.textColor = vm.ratingLblTextColor
        genresLbl.textColor = vm.releaseDateTextColor

        contentView.backgroundColor = vm.backgroundColor
        cellSeperatorView.backgroundColor = vm.seperatorColor
        lablesStackWidth.constant = frame.width / 2
    }
}
