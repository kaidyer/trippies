//
//  TrippiesViewModel.swift
//  Trippies
//
//  Created by Kai Dyer on 2/21/26.
//


import SwiftUI

class TrippiesViewModel: ObservableObject {
    @Published var trippies: [String: TrippieCategory] = [:]
    
    init() {
        startApp()
    }
    
    func startApp() {
        let categories = ["Commutes", "Travel", "Other"]
        trippies = Dictionary(uniqueKeysWithValues: categories.map { category in
            (category, TrippieCategory(type: category, avgDuration: 0, trippies: []))
        })
    }
    
    func addTrippie(type: String, duration: Int, date: Date) {
        let trippie = Trippie(date: date, duration: duration, type: type)
        
        if var category = trippies[type] {
            category.trippies.append(trippie)
            trippies[type] = category
        } else {
            let newCategory = TrippieCategory(
                type: type,
                avgDuration: duration,
                trippies: [trippie]
            )
            trippies[type] = newCategory
        }
    }
}
