//
//  TrippieCategoryView.swift
//  Trippies
//
//  Created by Kai Dyer on 2/21/26.
//

import SwiftUI

struct TrippieCategoryView: View {
    let trippieCategory: TrippieCategory
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.tileColor)
                .frame(width: 360, height: 150)
                .shadow(color: .black, radius: 10, x: 10, y: 10)
            VStack(alignment: .leading) {
                Text(trippieCategory.type)
                    .font(.title)
                    .foregroundStyle(Color.textColor)
                    .bold()
                    .padding(20)
                VStack(alignment: .leading){
                    Text("Average Duration:")
                        .foregroundStyle(Color.textColor)
                    Text("\(trippieCategory.avgDuration) seconds")
                        .foregroundStyle(Color.textColor)
                }
                .padding(.leading)
            }
        }
    }
}

#Preview {
    let trippieCategory = TrippieCategory(type: "Travel", avgDuration: 35, trippies: [])
    TrippieCategoryView(trippieCategory: trippieCategory)
}
