// File: ios/SmartJournal/Sources/Views/NewEntryView.swift
import SwiftUI

struct NewEntryView: View {
    @ObservedObject var viewModel: JournalViewModel
    @State private var content: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Entry")) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newEntry = JournalEntry(id: UUID().uuidString, date: Date(), content: content)
                        viewModel.addEntry(newEntry)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(content.isEmpty)
                }
            }
        }
    }
}