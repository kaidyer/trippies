//
//  StartTrippieView.swift
//  Trippies
//
//  Created by Kai Dyer on 5/25/26.
//

import SwiftUI

struct StartTrippieView: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "plus")
                .font(.body.weight(.bold))
                .frame(width: 34, height: 34)
                .background(Color.white.opacity(0.22), in: Circle())

            Text("Log a trippie")
                .font(.headline)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 22)
        .frame(height: 58)
        .background(Color.headerColor, in: Capsule())
        .overlay {
            Capsule().stroke(Color.white.opacity(0.45), lineWidth: 1)
        }
        .shadow(color: Color.backgroundColor.opacity(0.42), radius: 18, x: 0, y: 10)
        .padding(.bottom, 14)
    }
}

#Preview {
    StartTrippieView()
}
