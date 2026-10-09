//
//  AddTrippieView.swift
//  Trippies
//
//  Created by Kai Dyer on 2/24/26.
//

import SwiftUI

struct AddTrippieView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TrippiesViewModel

    @State private var date = Date()
    @State private var duration = ""
    @State private var type = ""

    private var categories: [String] {
        viewModel.getTrippieCategories().sorted()
    }
    
    var isFormValid: Bool {
        guard let durationInt = Int(duration) else { return false }
        return durationInt > 0 && categories.contains(type)
    }

    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section("Details") {
                        Picker("Type of Trippie", selection: $type) {
                            ForEach(categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                        if categories.isEmpty {
                            Text("Create a category before adding a trippie.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        TextField("Duration (minutes)", text: $duration)
                            .keyboardType(.numberPad)
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                    }
                }
                .navigationTitle("New Trippie")
                .navigationBarTitleDisplayMode(.inline)
                .scrollContentBackground(.hidden)
                .background(Color.tileColor.opacity(0.24))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            if let durationInt = Int(duration) {
                                viewModel.addTrippie(icon: "car.fill", type: type, duration: durationInt, date: date)
                                dismiss()
                            }
                        }
                        .disabled(!isFormValid)
                    }
                }
            }
            .tint(Color.headerColor)
            .onAppear {
                if !categories.contains(type) {
                    type = categories.first ?? ""
                }
            }
            .onChange(of: categories) { _, updatedCategories in
                if !updatedCategories.contains(type) {
                    type = updatedCategories.first ?? ""
                }
            }
        }
    }
}
#Preview {
    AddTrippieView(viewModel: TrippiesViewModel())
}
