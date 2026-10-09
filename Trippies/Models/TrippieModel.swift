//
//  TrippieModel.swift
//  Trippies
//
//  Created by Kai Dyer on 2/21/26.
//

import SwiftUI

struct Trippie: Identifiable, Codable, CustomStringConvertible {
    let id: UUID
    let date: Date
    let duration: Int
    let type: String

    init(id: UUID = UUID(), date: Date, duration: Int, type: String) {
        self.id = id
        self.date = date
        self.duration = duration
        self.type = type
    }
    
    var description: String {
        return "\nTrippie: \(type)\n date: \(date)\n duration: \(duration)\n"
    }
}

struct TrippieCategory: Identifiable, Codable, CustomStringConvertible {
    let id: UUID
    let icon: String
    let type: String
    var avgDuration: Int
    var trippies: [Trippie]

    init(id: UUID = UUID(), icon: String, type: String, avgDuration: Int, trippies: [Trippie]) {
        self.id = id
        self.icon = icon
        self.type = type
        self.avgDuration = avgDuration
        self.trippies = trippies
    }
    
    var description: String {
        return "\nTrippieCategory: \(type)\n avgDuration: \(avgDuration)\n trippies: \(trippies))\n"
    }
}
