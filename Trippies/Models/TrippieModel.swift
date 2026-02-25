//
//  TrippieModel.swift
//  Trippies
//
//  Created by Kai Dyer on 2/21/26.
//

import SwiftUI

struct Trippie: Identifiable, CustomStringConvertible {
    let id = UUID()
    let date: Date
    let duration: Int
    let type: String
    
    var description: String {
        return "\nTrippie: \(type)\n date: \(date)\n duration: \(duration)\n"
    }
}

struct TrippieCategory: Identifiable, CustomStringConvertible {
    let id = UUID()
    let type: String
    let avgDuration: Int
    var trippies: [Trippie]
    
    var description: String {
        return "\nTrippieCategory: \(type)\n avgDuration: \(avgDuration)\n trippies: \(trippies))\n"
    }
}
