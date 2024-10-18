//
//  CoreDataService.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 18/10/24.
//


import CoreData
import SwiftUI

class CoreDataService: MatchDataSource {
    private let context = PersistenceController.shared.container.viewContext
    
    func fetchMatches(completion: @escaping (Result<[Match], Error>) -> Void) {
        let request: NSFetchRequest<UserDecision> = UserDecision.fetchRequest()
        do {
            let decisions = try context.fetch(request)
            // Transform CoreData objects into Matches array
            let matches: [Match] = decisions.map { decision in
                Match(id: decision.matchId ?? "",
                      name: decision.name ?? "",
                      age: Int(decision.age),
                      location: decision.location ?? "",
                      bio: decision.bio ?? "",
                      photo: decision.photo ?? "")
            }
            completion(.success(matches))
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveDecision(matchId: String, decision: Bool) {
        let userDecision = UserDecision(context: context)
        userDecision.matchId = matchId
        userDecision.decision = decision
        
        do {
            try context.save()
        } catch {
            print("Error saving decision: \(error)")
        }
    }
    
    func fetchDecisions() -> [UserDecision] {
        let request: NSFetchRequest<UserDecision> = UserDecision.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching decisions: \(error)")
            return []
        }
    }
    
    func saveUser(_ user: Match, decision: Bool?) {
            // Check if the user already exists in Core Data
            let fetchRequest: NSFetchRequest<UserDecision> = UserDecision.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "matchId == %@", user.id as CVarArg)

            do {
                let results = try context.fetch(fetchRequest)
                if let existingMatch = results.first {
                    // Update the existing match with new data
                    existingMatch.name = user.name
                    existingMatch.age = Int16(user.age)
                    existingMatch.location = user.location
                    existingMatch.decision = decision ?? false // Keep the decision
                } else {
                    // Create a new match if it doesn't exist
                    let match = UserDecision(context: context)
                    match.matchId = user.id
                    match.name = user.name
                    match.age = Int16(user.age)
                    match.location = user.location
                    match.decision = decision ?? false
                }

                // Save changes
                try context.save()
            } catch {
                print("Failed to save or update user: \(error)")
            }
        }

}
