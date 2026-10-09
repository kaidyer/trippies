//
//  AddTrippieCategoryView.swift
//  Trippies
//
//  Created by Kai Dyer on 5/25/26.
//

import SwiftUI

struct AddTrippieCategoryView: View {
    @Environment(\.dismiss) var dismiss // variable to dismiss page
    @ObservedObject var viewModel: TrippiesViewModel
    @State private var categoryName = ""
    @State private var icon = "bolt.car"
    @State private var validationMessage: String?
    private let iconsList = ["bolt.car", "bus", "bicycle"]
    
    var isFormValid: Bool {
        !categoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !viewModel.hasTrippieCategory(named: categoryName)
            && !icon.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Name", text: $categoryName)
                        .textInputAutocapitalization(.words)
                    if !categoryName.isEmpty,
                       categoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text("Category name cannot be blank.")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                    if viewModel.hasTrippieCategory(named: categoryName) {
                        Text("A category with this name already exists.")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                    Picker("Select an icon", selection: $icon) {
                        ForEach(iconsList, id: \.self) { iconName in
                            Image(systemName: iconName).tag(iconName)
                        }
                    }
                }
            }
            .navigationTitle("New Trippie Category")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(Color.tileColor.opacity(0.24))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        if viewModel.addTrippieCategory(icon: icon, type: categoryName) {
                            dismiss()
                        } else {
                            validationMessage = "Enter a category name that is not already in use."
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
            .alert("Invalid category", isPresented: Binding(
                get: { validationMessage != nil },
                set: { if !$0 { validationMessage = nil } }
            )) {
                Button("OK", role: .cancel) { validationMessage = nil }
            } message: {
                Text(validationMessage ?? "")
            }
        }
        .tint(Color.headerColor)
    }
}

#Preview {
    AddTrippieCategoryView(viewModel: TrippiesViewModel())
}
