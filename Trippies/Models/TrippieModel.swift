//
//  TrippieModel.swift
//  Trippies
//
//  Created by Kai Dyer on 2/21/26.
//

import SwiftUI

struct Trippie: Identifiable {
    let id = UUID()
    let date: Date
    let duration: Int
    let type: String
}

struct TrippieCategory: Identifiable {
    let id = UUID()
    let type: String
    let avgDuration: Int
    var trippies: [Trippie]
}
