// File: ios/SmartJournal/Sources/Views/EntryRowView.swift
import SwiftUI

struct EntryRowView: View {
    let entry: JournalEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.date, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(entry.content)
                .font(.body)
                .lineLimit(2)
            if let sentiment = entry.sentiment {
                Text("Sentiment: \(sentiment)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}