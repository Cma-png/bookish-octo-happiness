
// File: ios/SmartJournal/Sources/Models/JournalEntry.swift
import Foundation

struct JournalEntry: Identifiable, Codable {
    let id: String
    let date: Date
    let content: String
    var sentiment: String?
}
