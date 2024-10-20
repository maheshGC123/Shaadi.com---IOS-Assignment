//
//  APIService.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 18/10/24.
//

import CoreData
import Foundation


struct MatchURLConstants {
    static let fetchMatches = "https://randomuser.me/api/?results=10"
}

class APIService: MatchDataSource {
    let serviceProvider = APIServiceProvider()

    func fetchMatches(completion: @escaping (Result<[Match], Error>) -> Void) {
        serviceProvider.fetchData(from: MatchURLConstants.fetchMatches) { (result: Result<Root, Error>) in
            switch result {
            case .success(let decodedResponse):
                // Map the API response to Match objects
                let matchData = decodedResponse.results.map { $0.intomatch() }
                completion(.success(matchData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveDecision(matchId: String, decision: MatchStatus, completion: @escaping (Result<Void, Error>) -> Void) {
        // API-specific implementation, but typically this would not store locally
    }

    func fetchDecisions() -> [UserDecision] {
        return [] // API service doesn't store decisions locally
    }
}
