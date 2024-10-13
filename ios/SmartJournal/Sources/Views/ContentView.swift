
// File: ios/SmartJournal/Sources/Views/ContentView.swift
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JournalViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entries) { entry in
                    NavigationLink(destination: EntryDetailView(entry: entry)) {
                        EntryRowView(entry: entry)
                    }
                }
            }
            .navigationTitle("Journal")
            .toolbar {
                Button(action: { viewModel.showingNewEntryView = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewEntryView) {
                NewEntryView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.fetchEntries()
        }
    }
}
