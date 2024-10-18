//
//  APIService.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 18/10/24.
//

import CoreData
import Foundation

class APIService: MatchDataSource {
    func fetchMatches(completion: @escaping (Result<[Match], Error>) -> Void) {
        guard let url = URL(string: "https://randomuser.me/api/?results=10") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data,
               let decodedResponse = try? JSONDecoder().decode(Root.self, from: data) {
                let matchData = decodedResponse.results.map( { $0.intomatch() })
                completion(.success(matchData))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Decoding error"])))
            }
        }.resume()
    }
    
    func saveDecision(matchId: String, decision: Bool) {
        // API-specific implementation, but typically this would not store locally
    }

    func fetchDecisions() -> [UserDecision] {
        return [] // API service doesn't store decisions locally
    }
}
