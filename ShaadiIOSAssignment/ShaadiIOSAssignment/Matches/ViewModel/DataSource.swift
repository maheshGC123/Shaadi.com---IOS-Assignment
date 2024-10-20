//
//  DataSource.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 19/10/24.
//


class DataSource: MatchDataSource {
    private let apiCoreService = APIService()
    private let coreDataService = CoreDataService()
    
    func fetchMatches(completion: @escaping (Result<[Match], Error>) -> Void) {
        updateCoreData(completion: completion)
    }
    
    func saveDecision(matchId: String, decision: MatchStatus, completion: @escaping (Result<Void, Error>) -> Void) {
        coreDataService.saveDecision(matchId: matchId, decision: decision, completion: completion)
    }
    
    func fetchDecisions() -> [UserDecision] {
        return coreDataService.fetchDecisions()
    }
    
    private func updateCoreData(completion: @escaping (Result<[Match], Error>) -> Void) {
        apiCoreService.fetchMatches { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.updateCoreDataWithMatches(users)
                completion(.success(users)) // Pass users directly, no need to refetch
            case .failure:
                // Fetch from Core Data as a fallback in case of API failure
                self.coreDataService.fetchMatches(completion: completion)
            }
        }
    }
    
    private func updateCoreDataWithMatches(_ users: [Match]) {
        users.forEach { user in
            coreDataService.saveUser(user)
        }
    }
}
