//
//  TrippiesViewModel.swift
//  Trippies
//
//  Created by Kai Dyer on 2/21/26.
//


import SwiftUI

class TrippiesViewModel: ObservableObject {
    @Published var trippies: [TrippieCategory] = []
    
    init() {
        startApp()
    }
    
    func startApp() {
        let categories = ["Commutes", "Travel", "Other"]
        trippies = categories.map {TrippieCategory(type: $0, avgDuration: 0, trippies: [])}
    }
}
