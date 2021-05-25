//
//  MoviesCVC.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 27.5.21..
//

import UIKit

class MoviesCollectionVC: UICollectionViewController, Storyboarded {
    
    // MARK: - API
    var movies: [MovieVM]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Properties
    private let vm = MoviesCollectionVM()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: - Helper
    private func setUI() {
        collectionView.backgroundColor = vm.backgroundColor
    }
}

// MARK: UICollectionViewDelegate
extension MoviesCollectionVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movieVM = movies?[indexPath.row] else { return }
        
        let cell = collectionView.cellForItem(at: indexPath) as! MoviesCell
        let image = cell.moviePosterImgView.image!
        
        let vc = MovieDetailsVC.instantiate()
        vc.movieDetailVM = MovieDetailVM(movieVM: movieVM, posterImage: image)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MoviesCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.height)
    }
}

// MARK: - UICollectionViewDataSource
extension MoviesCollectionVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCell.id, for: indexPath) as? MoviesCell else { return UICollectionViewCell() }
        cell.vm = movies?[indexPath.row]
        return cell
    }
}
