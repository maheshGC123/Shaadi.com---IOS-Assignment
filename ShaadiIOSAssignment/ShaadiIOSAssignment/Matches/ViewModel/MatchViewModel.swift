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
    @Published var newMatches: [Match] = []
    @Published var descionMatches: [Match] = []
    @Published var showErrorView = false
    @Published var showLoader = false

    private var matchDataSource: MatchDataSource
    
    init(dataSource: MatchDataSource) {
        self.matchDataSource = dataSource
    }
    
    func fetchMatches() {
        showLoader = true
        matchDataSource.fetchMatches { result in
            DispatchQueue.main.async {
                self.showLoader = false
                self.showErrorView = false
                switch result {
                case .success(let matches):
                    self.matches = matches
                    self.loadDecisions()
                case .failure:
                    self.showErrorView = true
                }
            }
        }
    }
    
    func upadteMatchStatus(match: Match, status: MatchStatus) {
        matchDataSource.saveDecision(matchId: match.id, decision: status, completion: { [weak self]_ in
            self?.loadDecisions()
        })
    }

    func loadDecisions() {
        let decisions = matchDataSource.fetchDecisions()
        for decision in decisions {
            if let matchId = decision.matchId,
               let index = matches.firstIndex(where:  { $0.id == matchId }) {
                if decision.decision == MatchStatus.accepted.rawValue {
                    matches[index].status = MatchStatus.accepted.rawValue
                } else if decision.decision == MatchStatus.rejected.rawValue {
                    matches[index].status = MatchStatus.rejected.rawValue
                } else {
                    matches[index].status = MatchStatus.pending.rawValue
                }
            } else {
                matches.append(decision.toMatch())
            }
        }
        filterMatches()
    }
    
}

// MARK: - UI Manipulation
extension MatchViewModel {
    
    func filterMatches() {
        let (new, decided) = matches.reduce(into: (new: [Match](), decided: [Match]())) { result, match in
            if match.status == MatchStatus.pending.rawValue {
                result.new.append(match)
            } else {
                result.decided.append(match)
            }
        }
        newMatches = new
        descionMatches = decided
    }
    
}

