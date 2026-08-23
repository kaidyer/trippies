//
//  MyTrippiesView.swift
//  Trippies
//
//  Created by Kai Dyer on 8/22/26.
//

import SwiftUI

struct MyTrippiesView: View {
    let trippieCategory: TrippieCategory
    
    var body: some View {
        ForEach(trippieCategory.trippies) {
            trippie in Text(String(trippie.duration))
        }
        
    }
}

#Preview {
    let trippieA = Trippie(date: Date.now, duration: 34, type: "Travel")
    let trippieB = Trippie(date: Date.now, duration: 36, type: "Travel")
    let trippieCategory = TrippieCategory(type: "Travel", avgDuration: 35, trippies: [trippieA, trippieB])
    MyTrippiesView(trippieCategory: trippieCategory)
}
