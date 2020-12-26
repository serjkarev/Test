//
//  RepoResponse.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import Foundation

struct RepoResponse: Decodable {
    let data: [Repo]
}

struct Repo: Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let picture: String
}

enum Gender: String, Decodable {
    case female
    case male
    case notDetemine
}

enum Title: String, Codable {
    case mrs
    case mr
    case ms
    case miss
    case dr
    case notDetemine = ""
}

struct Location: Codable {
    let street: String
    let timezone: String
    let state: String
    let country: String
}

struct RepoProfile: Decodable {
    let id: String
    let gender: Gender
    let birthday: String
    let title: Title
    let lastName: String
    let firstName: String
    let email: String
    let pictureURL: String
    let phone: String
    let registerDate: String
    let location: Location
}

extension RepoProfile {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case gender
        case birthday = "dateOfBirth"
        case title
        case lastName
        case firstName
        case email
        case pictureURL = "picture"
        case phone
        case registerDate
        case location
    }
}

extension RepoProfile {
    var fullName: String {
        return title.rawValue.capitalized + " " + firstName + " " + lastName
    }
    
    var fullLocation: String {
        return location.street + " " + location.state + " " + location.country
    }
}

extension Repo {
    var fullName: String {
        return firstName + " " + lastName
    }
}

extension RepoProfile {
    static func emptyProfile() -> RepoProfile {
        let location = Location(street: "", timezone: "", state: "", country: "")
        return RepoProfile(id: "", gender: .notDetemine, birthday: "", title: .notDetemine,
                           lastName: "", firstName: "", email: "", pictureURL: "",
                           phone: "", registerDate: "", location: location)
    }
}

