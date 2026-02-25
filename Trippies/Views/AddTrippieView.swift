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

    var body: some View {
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
                        print("Tapped")
                    }
                }
            }
        }
    }
}
#Preview {
    AddTrippieView(viewModel: TrippiesViewModel())
}
