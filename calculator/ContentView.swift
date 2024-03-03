//
//  ContentView.swift
//  calculator
//
//  Created by Harnoor Singh on 2/24/24.
//

import SwiftUI

struct ContentView: View {
    @State var text2: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "hands.clap")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                TextField("Hello, world!", text: $text2)
                    .padding()
                    .buttonStyle(.bordered)
                    .border(.secondary)
                NavigationLink(destination: Page2View(textFromPage1: $text2)) {
                    Label("Go to Page 2", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
