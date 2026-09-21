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
        HStack {
            Text("Category: \(trippieCategory.type)")
                .font(.title)
                .bold()
                .padding()
            Spacer()
        }
        Spacer()
        ForEach(trippieCategory.trippies) {
            trippie in aTrippie(trippie: trippie).padding()
        }
        Spacer()
        
    }
}

struct aTrippie: View {
    let trippie: Trippie
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.tile)
            HStack {
                Text("Date:")
                Text(trippie.date, format: .dateTime
                    .month(.abbreviated)
                    .day()
                    .year())
                Text("Duration: \(trippie.duration) minutes")
            }
            .foregroundStyle(.text)
            
        }
    }
}

#Preview {
    let trippieA = Trippie(date: Date.now, duration: 34, type: "Travel")
    let trippieB = Trippie(date: Date.now, duration: 36, type: "Travel")
    let trippieC = Trippie(date: Date.now, duration: 36, type: "Travel")
    let trippieCategory = TrippieCategory(type: "Travel", avgDuration: 35, trippies: [trippieA, trippieB, trippieC])
    MyTrippiesView(trippieCategory: trippieCategory)
}
