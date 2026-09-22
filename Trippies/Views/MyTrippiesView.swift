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
            Text(trippieCategory.type)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.textColor.opacity(0.72))
                .textCase(.uppercase)
                .tracking(1.2)
                .padding(.horizontal, 4)
            Spacer()
        }
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
            VStack {
                Text(trippie.date, format: .dateTime
                    .month(.abbreviated)
                    .day()
                    .year())
                .font(.title3.weight(.bold))
                .foregroundStyle(Color.textColor)
                Text("Duration: \(trippie.duration) minutes")
                    .font(.subheadline)
                    .foregroundStyle(Color.textColor.opacity(0.72))
            }
            .padding(18)
            .frame(maxWidth: .infinity, minHeight: 94)
            .background(Color.surfaceColor, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
            }
            .shadow(color: Color.softShadow, radius: 16, x: 0, y: 9)
            
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
