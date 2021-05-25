//
//  ImageHelper.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 24.5.21..
//

import UIKit

class ImageHelper {
    
    // MARK: - API
    static let shared = ImageHelper()

    var imageCache = NSCache<NSString, UIImage>()    
}
