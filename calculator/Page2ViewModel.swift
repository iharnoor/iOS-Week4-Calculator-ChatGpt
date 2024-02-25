//
//  Page2ViewModel.swift
//  calculator
//
//  Created by Harnoor Singh on 2/24/24.
//

import Foundation
import SwiftUI

class Page2ViewModel: ObservableObject {
    @Published var user: GitHubUser?
    
    func fetchUser() async {
        do {
            user = try await getUser()
        } catch {
            print("Error fetching user:", error)
        }
    }
    
    func getUser() async throws -> GitHubUser { // many things can go wrong}
        let endpoint =  "https://api.github.com/users/iharnoor"
        
        guard let url = URL(string:endpoint) else { throw GHError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}
