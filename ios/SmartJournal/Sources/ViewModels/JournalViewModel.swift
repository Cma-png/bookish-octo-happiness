
// File: ios/SmartJournal/Sources/ViewModels/JournalViewModel.swift
import SwiftUI
import Combine

class JournalViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []
    @Published var showingNewEntryView = false
    
    private var notionService = NotionService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchEntries() {
        notionService.fetchEntries()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] entries in
                self?.entries = entries
            })
            .store(in: &cancellables)
    }
    
    func addEntry(_ entry: JournalEntry) {
        notionService.addEntry(entry)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] newEntry in
                self?.entries.insert(newEntry, at: 0)
                self?.showingNewEntryView = false
            })
            .store(in: &cancellables)
    }
}

// File: ios/SmartJournal/Sources/ViewModels/JournalViewModel.swift
// Add this method to the existing JournalViewModel class
extension JournalViewModel {
    func getAdvice(for entry: JournalEntry) -> String? {
        // In a real app, you would call your LLM service here
        // This is a placeholder implementation
        return "Based on your entry, consider taking a short walk to clear your mind."
    }
}
