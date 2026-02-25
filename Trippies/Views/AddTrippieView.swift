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
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                        
                        TextField("Duration (minutes)", text: $duration)
                            .keyboardType(.numberPad)
                        
                        TextField("Type", text: $type)
                    }
                }
                .navigationTitle("New Trippie")
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
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
//            Button("Print") {
//                print(viewModel.trippies)
//            }
        }
    }
}
#Preview {
    AddTrippieView(viewModel: TrippiesViewModel())
}
