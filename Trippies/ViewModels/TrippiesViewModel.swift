//
//  TrippiesViewModel.swift
//  Trippies
//
//  Created by Kai Dyer on 2/21/26.
//


import SwiftUI

class TrippiesViewModel: ObservableObject {
    @Published var trippies: [String: TrippieCategory] = [:]
    private let persistenceKey = "trippies.categories.v1"
    private let recoveryKey = "trippies.categories.v1.corrupt-backup"
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        startApp()
    }
    
    func startApp() {
        if let savedData = defaults.data(forKey: persistenceKey) {
            do {
                trippies = try JSONDecoder().decode([String: TrippieCategory].self, from: savedData)
                return
            } catch {
                // Keep the original bytes recoverable before falling back to defaults.
                if defaults.data(forKey: recoveryKey) == nil {
                    defaults.set(savedData, forKey: recoveryKey)
                }
            }
        }

        let categories = ["Commutes", "Travel", "Other"]
        let icons: [String: String] = [
            "Commutes": "car.fill",
            "Travel": "airplane.departure",
            "Other": "map.fill"]
        trippies = Dictionary(uniqueKeysWithValues: categories.map { category in
            (category, TrippieCategory(icon: icons[category] ?? "map.fill", type: category, avgDuration: 0, trippies: []))
        })
        // A fresh install gets starter categories saved. Corrupt data remains at the
        // original key and in the recovery key until the user changes app data.
        if defaults.data(forKey: persistenceKey) == nil {
            persistTrippies()
        }
    }
    
    // Section: Adding methods
    
    @discardableResult
    func addTrippie(icon: String, type: String, duration: Int, date: Date) -> Bool {
        let normalizedType = type.trimmingCharacters(in: .whitespacesAndNewlines)
        guard duration > 0, !normalizedType.isEmpty,
              var category = trippies[normalizedType] else { return false }
        let trippie = Trippie(date: date, duration: duration, type: normalizedType)
        category.trippies.append(trippie)
        let totalDuration = category.trippies.reduce(0) { $0 + $1.duration }
        category.avgDuration = totalDuration / category.trippies.count
        trippies[normalizedType] = category
        persistTrippies()
        return true
    }
    
    @discardableResult
    func addTrippieCategory(icon: String, type: String) -> Bool {
        let normalizedType = type.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !normalizedType.isEmpty,
              !icon.isEmpty,
              !hasTrippieCategory(named: normalizedType) else { return false }
        let newCategory = TrippieCategory(
            icon: icon,
            type: normalizedType,
            avgDuration: 0,
            trippies: []
        )
        trippies[normalizedType] = newCategory
        persistTrippies()
        return true
    }

    func hasTrippieCategory(named name: String) -> Bool {
        let normalizedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !normalizedName.isEmpty else { return false }
        return trippies.keys.contains {
            $0.caseInsensitiveCompare(normalizedName) == .orderedSame
        }
    }
    
    // Section: Getters
    
    func getTrippieCategories() -> [String] {
        return trippies.values.map { $0.type }
    }

    private func persistTrippies() {
        guard let data = try? JSONEncoder().encode(trippies) else { return }
        defaults.set(data, forKey: persistenceKey)
    }
}
