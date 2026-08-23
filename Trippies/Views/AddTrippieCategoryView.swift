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
    
    var isFormValid: Bool {
        // All fields must be non-empty
        !categoryName.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Name", text: $categoryName)
                }
            }
            .navigationTitle("New Trippie Category")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(Color.tileColor.opacity(0.24))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        viewModel.addTrippieCategory(type: categoryName)
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .tint(Color.headerColor)
    }
}

#Preview {
    AddTrippieCategoryView(viewModel: TrippiesViewModel())
}
