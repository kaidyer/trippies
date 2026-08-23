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
    
    var isFormValid: Bool {
        // All fields must be non-empty, and duration must convert to an Int
        !type.isEmpty && !duration.isEmpty && Int(duration) != nil
    }

    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section("Details") {
                        Picker("Type of Trippie", selection: $type) {
                            ForEach(viewModel.getTrippieCategories().sorted(), id: \.self) { category in
                                Text(category).tag(category)
                            }
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
                                viewModel.addTrippie(type: type, duration: durationInt, date: date)
                                dismiss()
                            }
                        }
                        .disabled(!isFormValid)
                    }
                }
            }
            .tint(Color.headerColor)
        }
    }
}
#Preview {
    AddTrippieView(viewModel: TrippiesViewModel())
}
