//
//  MoviesCell.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 27.5.21..
//

import UIKit

class MoviesCell: UICollectionViewCell {
    
    // MARK: - API
    static let id = "MoviesCell"
    
    var vm: MovieVM? {
        willSet {
            updateUI(vm: newValue)
        }
    }
    
    // MARK: - Properties
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var moviePosterImgView: MovieImageView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieNameWidth: NSLayoutConstraint!
    @IBOutlet weak var moviePosterWidth: NSLayoutConstraint!
    @IBOutlet weak var moviePosterHeight: NSLayoutConstraint!
    
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        
        moviePosterImgView.cancelImageDownload()
    }
    
    // MARK: - Helper
    private func updateUI(vm: MovieVM?) {
        guard let vm = vm else { return }
        
        // text and images
        movieNameLbl.text = vm.title
        ratingLbl.text = vm.rating
        moviePosterImgView.image = vm.placeHolderImage
        ratingImageView.image = vm.ratingImage
        moviePosterImgView.vm = MovieImageVM(imageUrlString: vm.posterUrl)
        
        // colors
        movieNameLbl.textColor = vm.movieTxtColor
        ratingLbl.textColor = vm.ratingTxtColor
        contentView.backgroundColor = vm.backgroundColor
        containerView.backgroundColor = vm.containerBackgroundColor

        // fonts
        movieNameLbl.font = vm.movieTitleLblFont
        ratingLbl.font = vm.ratingLblFont
        
        // UX
        movieNameLbl.numberOfLines = vm.maxNumberOfLines
        movieNameWidth.constant = frame.width - vm.movieTitlePaddingBothSides
        moviePosterHeight.constant = frame.height - vm.posterPaddingDown
        moviePosterWidth.constant = frame.width - vm.posterPaddingBothSides
        containerView.layer.cornerRadius = vm.cornerRadius
    }
}
