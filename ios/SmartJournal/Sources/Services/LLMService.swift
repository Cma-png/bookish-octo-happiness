// File: ios/SmartJournal/Sources/Services/LLMService.swift
import Foundation
import Combine

class LLMService {
    private let baseURL = "https://your-backend-url.com/api"
    
    func analyzeEntry(_ entry: JournalEntry) -> AnyPublisher<String, Error> {
        let url = URL(string: "\(baseURL)/analyze")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["content": entry.content]
        request.httpBody = try? JSONEncoder().encode(body)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: AnalysisResponse.self, decoder: JSONDecoder())
            .map { $0.advice }
            .eraseToAnyPublisher()
    }
}

struct AnalysisResponse: Codable {
    let sentiment: String
    let advice: String
}