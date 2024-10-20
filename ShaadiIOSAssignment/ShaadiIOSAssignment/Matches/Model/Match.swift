//
//  Match.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 18/10/24.
//


import Foundation

enum MatchStatus: String {
    case accepted = "Accepted"
    case rejected = "Declined"
    case pending
}

struct Match: Identifiable, Codable {
    let id: String
    let name: String
    let age: Int
    let location: String
    let bio: String
    let photo: String
    var status: String?
}


//MARK: - API object into UI object
extension User {
    func intomatch() -> Match {
        Match(id: self.id?.value ?? "",
              name: self.name?.getFullname() ?? "",
              age: self.dob?.age ?? 0,
              location:  self.location?.getAddress() ?? "",
              bio: "",
              photo: self.picture?.thumbnail ?? "")
    }
    
}

//MARK: - core data object into UI object
extension UserDecision {
    func toMatch() -> Match {
        Match(id: self.matchId ?? "",
              name: self.name ?? "",
              age: Int(self.age),
              location: self.location ?? "",
              bio: self.bio ?? "",
              photo: self.photo ?? "",
              status: self.decision)
    }
}

 
struct Root: Codable {
    let results: [User]
}

struct User: Codable {
    let name: Name?
    let location: Location?
    let dob: DateOfBirth?
    let id: ID?
    let picture: Picture?
}

// MARK: - Name
struct Name: Codable {
    let title: String
    let first: String
    let last: String
    
    func getFullname() -> String {
        self.title +  " " +  self.first + " " + self.last
    }
}

// MARK: - Location
struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    
    func getAddress() -> String {
        street.getStreetName() + " " + self.city + " " + self.state + " " + self.country
    }
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
    
    func getStreetName() -> String {
        String(self.number) + " " + self.name
    }
}

// MARK: - DateOfBirth
struct DateOfBirth: Codable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Codable {
    let name: String
    let value: String?
}

// MARK: - Picture
struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
