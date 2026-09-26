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
        let icons: [String: String] = [
            "Commutes": "car.fill",
            "Travel": "airplane.departure",
            "Other": "map.fill"]
        trippies = Dictionary(uniqueKeysWithValues: categories.map { category in
            (category, TrippieCategory(icon: icons[category] ?? "map.fill", type: category, avgDuration: 0, trippies: []))
        })
    }
    
    // Section: Adding methods
    
    func addTrippie(icon: String, type: String, duration: Int, date: Date) {
        let normalizedType = type.trimmingCharacters(in: .whitespacesAndNewlines)
        let trippie = Trippie(date: date, duration: duration, type: normalizedType)
        
        if var category = trippies[normalizedType] {
            category.trippies.append(trippie)
            let totalDuration = category.trippies.reduce(0) { $0 + $1.duration }
            category.avgDuration = totalDuration / category.trippies.count
            trippies[normalizedType] = category
        } else {
            let newCategory = TrippieCategory(
                icon: icon,
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
                icon: "map.fill",
                type: normalizedType,
                avgDuration: 0,
                trippies: []
            )
            trippies[normalizedType] = newCategory
        }
    }
    
    // Section: Getters
    
    func getTrippieCategories() -> [String] {
        return trippies.values.map { $0.type }
    }
}
