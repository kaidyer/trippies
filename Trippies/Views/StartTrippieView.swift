//
//  StartTrippieView.swift
//  Trippies
//
//  Created by Kai Dyer on 5/25/26.
//

import SwiftUI

struct StartTrippieView: View {
    var body: some View {
        VStack {
            
            ZStack {
                Circle()
                    .fill(.header)
                    .frame(width: 100)
                Circle()
                    .fill(Color.tileColor)
                    .frame(width: 90)
                Text("Start")
                    .foregroundStyle(Color.textColor)
                    .bold()
            }
        }
    }
}

#Preview {
    StartTrippieView()
}
