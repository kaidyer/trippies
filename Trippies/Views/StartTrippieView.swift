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
            Text("Start a Trippiee")
                .bold()
            ZStack {
                Circle()
                    .fill(.header)
                    .frame(width: 100)
                Circle()
                    .fill(Color.tileColor)
                    .frame(width: 90)
            }
        }
    }
}

#Preview {
    StartTrippieView()
}
