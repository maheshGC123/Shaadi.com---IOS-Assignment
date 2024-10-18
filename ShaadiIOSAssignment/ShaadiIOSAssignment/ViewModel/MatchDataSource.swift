//
//  MatchDataSource.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 18/10/24.
//
import CoreData

protocol MatchDataSource {
    func fetchMatches(completion: @escaping (Result<[Match], Error>) -> Void)
    func saveDecision(matchId: String, decision: Bool)
    func fetchDecisions() -> [UserDecision]
}
