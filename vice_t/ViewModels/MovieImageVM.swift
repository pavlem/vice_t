//
//  HomeImageVM.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 24.5.21..
//

import UIKit

class MovieImageVM {
    
    var imageUrlString: String
    var imagePlaceholderName: String
    var isRounded = false
    var imageTransition = Double(0.7)

    init(imageUrlString: String, imagePlaceholderName: String = "demoImg") {
        self.imageUrlString = imageUrlString
        self.imagePlaceholderName = imagePlaceholderName
    }

    func getImage(withName imageName: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        urlSessionDataTask = moviewService.fetch(image: imageName, completion: { (result) in
            completion(result)
        })
    }
    
    func cancelImageDownload() {
        urlSessionDataTask?.cancel()
    }
    
    // MARK: - Properties
    private var urlSessionDataTask: URLSessionDataTask?
    private let moviewService = MoviesService()
}

extension MovieImageVM {
    func getCachedImage(imageName: String) -> UIImage? {
        if let image = ImageHelper.shared.imageCache.object(forKey: imageName as NSString) {
            return image
        }
        return nil
    }
    
    func cache(image: UIImage, key: String) {
        ImageHelper.shared.imageCache.setObject(image, forKey: key as NSString)
    }
}
