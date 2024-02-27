//
//  Page2ViewModel.swift
//  calculator
//
//  Created by Harnoor Singh on 2/24/24.
//

import Foundation
import SwiftUI

class Page2ViewModel: ObservableObject {
    @Published var user: ChatGptResponse?
    
    func getChatGptResponse() async throws -> ChatGptResponse { // many things can go wrong}
        let endpoint =  "https://raw.githubusercontent.com/iharnoor/iOS-Week4-Calculator-ChatGpt/main/server.json"
        
        guard let url = URL(string:endpoint) else { throw ChatGptError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ChatGptError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(ChatGptResponse.self, from: data)
        } catch {
            throw ChatGptError.invalidData
        }
    }
}
