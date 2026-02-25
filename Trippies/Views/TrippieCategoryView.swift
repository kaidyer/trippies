//
//  TrippieCategoryView.swift
//  Trippies
//
//  Created by Kai Dyer on 2/21/26.
//

import SwiftUI

struct TrippieCategoryView: View {
    let type: String
    var avgDuration: Int = 0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("PrimaryColor"))
                .stroke(Color("SecondaryColor"), lineWidth: 5)
                .frame(width: 360, height: 150)
                .shadow(color: .black, radius: 10, x: 10, y: 10)
            VStack(alignment: .leading) {
                Text(type)
                    .font(.title)
                    .bold()
                    .padding(20)
                VStack(alignment: .leading){
                    Text("Average Duration:")
                    Text("\(avgDuration) seconds")
                }
                .background(RoundedRectangle(cornerRadius: 5).fill(Color("SecondaryColor")))
                .padding(.leading)
            }
        }
    }
}

#Preview {
    TrippieCategoryView(type: "Trippies", avgDuration: 5)
}
