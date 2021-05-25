//
//  MoviesRequest.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 28.5.21..
//

import Foundation

class MoviesRequest {
    let page: Int?
    let apiKey = "96041f826a92d167e44bc28be53f72e0"
    
    init(page: Int?) {
        self.page = page
    }
}

extension MoviesRequest {
    
    func body() -> NetworkService.JSON {
        var params: [String: Any] = [
            "api_key": apiKey,
        ]
        
        if let page = self.page {
            params["page"] = page
        }
        
        return params
    }
}
