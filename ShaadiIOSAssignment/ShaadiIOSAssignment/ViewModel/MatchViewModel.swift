//
//  MatchViewModel.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 18/10/24.
//


import Combine
import SwiftUI

class MatchViewModel: ObservableObject {
    @Published var matches: [Match] = []
    @Published var acceptedMatches: Set<String> = []
    @Published var declinedMatches: Set<String> = []
    
    private var matchDataSource: MatchDataSource
    
    init(dataSource: MatchDataSource) {
        self.matchDataSource = dataSource
    }
    
    func fetchMatches() {
        matchDataSource.fetchMatches { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let matches):
                    self.matches = matches
                case .failure(let error):
                    print("Error fetching matches: \(error)")
                }
            }
        }
    }
    
    func acceptMatch(match: Match) {
        acceptedMatches.insert(match.id)
        matchDataSource.saveDecision(matchId: match.id, decision: true)
    }
    
    func declineMatch(match: Match) {
        declinedMatches.insert(match.id)
        matchDataSource.saveDecision(matchId: match.id, decision: false)
    }
    
    func loadDecisions() {
        let decisions = matchDataSource.fetchDecisions()
        for decision in decisions {
            guard let matchId = decision.matchId else { continue }
            if decision.decision{
                acceptedMatches.insert(matchId)
            } else {
                declinedMatches.insert(matchId)
            }
        }
    }
}

class DataSource: MatchDataSource {
    let apiCoreServie = APIService()
    let coreDataService = CoreDataService()
    
    
    func fetchMatches(completion: @escaping (Result<[Match], any Error>) -> Void) {
        coreDataService.fetchMatches(completion: completion)
        updateCoreData()
    }
    
    func saveDecision(matchId: String, decision: Bool) {
        coreDataService.saveDecision(matchId: matchId, decision: decision)
    }
    
    func fetchDecisions() -> [UserDecision] {
        coreDataService.fetchDecisions()
    }
    
    func updateCoreData() {
        apiCoreServie.fetchMatches { [weak self] result in
                   switch result {
                   case .success(let users):
                       self?.updateCoreDataWithMatches(users)
                   case .failure(let error):
                       print("Failed to fetch matches from API: \(error)")
                   }
               }
    }
    
    private func updateCoreDataWithMatches(_ users: [Match]) {
           users.forEach { user in
               coreDataService.saveUser(user, decision: nil)
           }
       }
    
    
}
