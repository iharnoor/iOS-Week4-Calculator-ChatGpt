//
//  Page2View.swift
//  calculator
//
//  Created by Harnoor Singh on 2/24/24.
//

import SwiftUI

struct Page2View: View {
    @Binding var text3: String
    @State var response: ChatGptResponse?
    
    @StateObject private var viewModel = Page2ViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Received from Page 1 \(text3)")
            Text(response?.message ?? "Not found")
                .bold()
                .font(.title3)
        }
        .padding()
        .task {
            do {
                response = try await viewModel.getChatGptResponse()
            } catch {
                print("Error fetching user:", error)
            }
        }
    }
}

struct ChatGptResponse: Codable {
    let message: String
}

enum ChatGptError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

#Preview {
    Page2View(text3: .constant("Hello"))
}
