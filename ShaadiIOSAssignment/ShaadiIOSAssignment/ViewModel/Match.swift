//
//  Match.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 18/10/24.
//


import Foundation

struct Match: Identifiable, Codable {
    let id: String
    let name: String
    let age: Int
    let location: String
    let bio: String
    let photo: String
}

struct Root: Codable {
    let results: [User]
}

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
 
struct User: Codable {
   let gender: String
    let name: Name?
    let location: Location?
   let email: String
   let login: Login
    let dob: DateOfBirth?
   let registered: Registered
    let phone: String?
    let cell: String
    let id: ID?
    let picture: Picture?
    let nat: String
}

// MARK: - Name
struct Name: Codable {
    let title: String
    let first: String
    let last: String
    
    func getFullname() -> String {
        self.title + self.first + self.last
    }
}


// MARK: - Location
struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: StringOrInt
    let coordinates: Coordinates
    let timezone: Timezone
    
    func getAddress() -> String {
        self.city + self.state + self.country
    }
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset: String
    let description: String
}

// MARK: - Login
struct Login: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

// MARK: - DateOfBirth
struct DateOfBirth: Codable {
    let date: String
    let age: Int
}

// MARK: - Registered
struct Registered: Codable {
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

// MARK: - StringOrInt
enum StringOrInt: Codable {
    case string(String)
    case int(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(StringOrInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected String or Int"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        }
    }
}
