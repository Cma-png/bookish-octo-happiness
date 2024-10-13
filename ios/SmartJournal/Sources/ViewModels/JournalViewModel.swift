
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
