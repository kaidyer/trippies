//
//  ContentView.swift
//  Trippies
//
//  Created by Kai Dyer on 2/21/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TrippiesViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Trippies")
            ForEach(Array(viewModel.trippies.values)) { trippieCategory in
                TrippieCategoryView(trippieCategory: trippieCategory)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
