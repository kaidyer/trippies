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
        VStack {
            HeaderView()
            NavigationStack {
                VStack(alignment: .leading) {
                
                    ForEach(Array(viewModel.trippies.values).sorted { $0.type < $1.type }) { trippieCategory in
                        TrippieCategoryView(trippieCategory: trippieCategory)
                    }
                    
                    NavigationLink("Add Trippie") {
                        AddTrippieView(viewModel: viewModel)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
