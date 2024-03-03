//
//  Page2ViewModel.swift
//  calculator
//
//  Created by Harnoor Singh on 3/3/24.
//

import Foundation

class Page2ViewModel: ObservableObject {
    
    
    // convert this to a viewmodel MVVM structure
    func getResponseFromServer(textFromPage1: String) async throws -> ChatGptResponse {
        let endPoint = "https://chatgptvm.eastus.cloudapp.azure.com/api/chatgpt/\(textFromPage1)"
        guard let url = URL(string: endPoint) else {
            throw ChatGptError.URLError
        }
        let (data, response) =  try await URLSession.shared.data(from: url) // type -> 2
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else {
            // todo
            throw ChatGptError.ResponseError
        }
        let decoder = JSONDecoder()
        let chatGptResponse = try decoder.decode(ChatGptResponse.self, from: data)
        
        return chatGptResponse
    }
}

enum ChatGptError: Error {
    case ResponseError
    case URLError
}

struct ChatGptResponse: Codable { // conforms to a protocol Codable
    var message: String
}

