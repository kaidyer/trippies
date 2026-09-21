//
//  ContentView.swift
//  Trippies
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TrippiesViewModel()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.backgroundColor, Color.backgroundColor.opacity(0.78), Color.tileColor],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(Color.white.opacity(0.12))
                .frame(width: 280)
                .blur(radius: 2)
                .offset(x: 150, y: -300)

            VStack(spacing: 0) {
                HeaderView()

                NavigationStack {
                    ZStack(alignment: .bottom) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Your trip log")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(Color.textColor.opacity(0.72))
                                    .textCase(.uppercase)
                                    .tracking(1.2)
                                    .padding(.horizontal, 4)

                                ForEach(Array(viewModel.trippies.values).sorted { $0.type < $1.type }) { trippieCategory in
                                    TrippieCategoryView(trippieCategory: trippieCategory)
                                }

                                NavigationLink {
                                    AddTrippieCategoryView(viewModel: viewModel)
                                } label: {
                                    CreateTrippieCategoryView()
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 24)
                            .padding(.bottom, 116)
                        }
                        .scrollIndicators(.hidden)

                        NavigationLink {
                            AddTrippieView(viewModel: viewModel)
                        } label: {
                            StartTrippieView()
                        }
                    }
                    .background(.clear)
                }
                .tint(Color.headerColor)
            }
        }
    }
}

#Preview {
    ContentView()
}
