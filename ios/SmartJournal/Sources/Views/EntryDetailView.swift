// File: ios/SmartJournal/Sources/Views/EntryDetailView.swift
import SwiftUI

struct EntryDetailView: View {
    let entry: JournalEntry
    @ObservedObject var viewModel: JournalViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(entry.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(entry.content)
                    .font(.body)
                
                if let sentiment = entry.sentiment {
                    Text("Sentiment: \(sentiment)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let advice = viewModel.getAdvice(for: entry) {
                    Text("Advice:")
                        .font(.headline)
                    Text(advice)
                        .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Journal Entry")
    }
}