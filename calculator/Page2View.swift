//
//  Page2View.swift
//  calculator
//
//  Created by Harnoor Singh on 2/24/24.
//

import SwiftUI


extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}

struct Page2View: View {
    @Binding var textFromPage1: String
    @State var response: ChatGptResponse?
    
    @StateObject private var viewModel = Page2ViewModel()
    @State var isHidden = false

    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Received from Page 1 \(textFromPage1)")
            Text(response?.message ?? "")
                .bold()
                .font(.title3)
            ProgressView()
                .isHidden(isHidden)
        }
        .padding()
        .task {
            do {
                response = try await viewModel.getResponseFromServer(textFromPage1: textFromPage1) // todo pass text3
                isHidden = true
            } catch ChatGptError.URLError {
                print("Error found in the URL")
            } catch ChatGptError.ResponseError {
                print("Server down")
            } catch {
                print("Something else", error)
            }
        }
    }
}

#Preview {
    Page2View(textFromPage1: .constant("Hello"))
}
