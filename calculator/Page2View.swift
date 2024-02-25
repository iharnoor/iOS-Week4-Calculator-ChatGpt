//
//  Page2View.swift
//  calculator
//
//  Created by Harnoor Singh on 2/24/24.
//

import SwiftUI

struct Page2View: View {
    @Binding var text3: String
    
    @StateObject private var viewModel = Page2ViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Received from Page 1 \(text3)")
        }
        .padding()
        .task {
            await viewModel.fetchUser()
        }
    }
}


struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

#Preview {
    Page2View(text3: .constant("Hello"))
}
