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
        let normalizedType = type.trimmingCharacters(in: .whitespacesAndNewlines)
        let trippie = Trippie(date: date, duration: duration, type: normalizedType)
        
        if var category = trippies[normalizedType] {
            category.trippies.append(trippie)
            let totalDuration = category.trippies.reduce(0) { $0 + $1.duration }
            let averageDuration = totalDuration / category.trippies.count
            trippies[normalizedType] = TrippieCategory(
                type: category.type,
                avgDuration: averageDuration,
                trippies: category.trippies
            )
        } else {
            let newCategory = TrippieCategory(
                type: normalizedType,
                avgDuration: duration,
                trippies: [trippie]
            )
            trippies[normalizedType] = newCategory
        }
    }
    
    func addTrippieCategory(type: String) {
        let normalizedType = type.trimmingCharacters(in: .whitespacesAndNewlines)
        if trippies[normalizedType] == nil {
            let newCategory = TrippieCategory(
                type: normalizedType,
                avgDuration: 0,
                trippies: []
            )
            trippies[normalizedType] = newCategory
        }
    }
}
