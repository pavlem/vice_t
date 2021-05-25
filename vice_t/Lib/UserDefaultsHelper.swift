//
//  UserDefaultsHelper.swift
//  vice_t
//
//   Created by Pavle Mijatovic on 24.5.21..
//

import Foundation

class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    
    enum Keys: String, CaseIterable {
        case movie
        
        var string: String {
            return self.rawValue
        }
    }
    
    // MARK: - Properties
    var movies: Data? {
        get {
            return UserDefaults.standard.data(forKey: Keys.movie.string)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.movie.string)
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: - API
    func loadPersistedMovies(success: ([Movie]) -> Void, fail: () -> Void) {
        guard let moviesData = UserDefaultsHelper.shared.movies else {
            fail()
            return
        }
        
        do {
            let decodedHomes = try JSONDecoder().decode([Movie].self, from: moviesData)
            success(decodedHomes)
        } catch {
            fail()
        }
    }
}
