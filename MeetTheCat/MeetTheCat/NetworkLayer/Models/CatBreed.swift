//
//  CatBreed.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import UIKit

struct CatBreed: Codable {
    var name: String?
    var catDescription: String?
    var temperament: String?
    var vetstreetUrl: String?
    var origin: String?
    var indoor: Int?
    var childFriendly: Int?
    var dogFriendly: Int?
    var energyLevel: Int?
    var grooming: Int?
    var healthIssues: Int?
    var intelligence: Int?
    var sheddingLevel: Int?
    var socialNeeds: Int?
    var strangerFriendly: Int?
    var vocalisation: Int?
    var experimental: Int?
    var hairless: Int?
    var natural: Int?
    var rare: Int?
    var rex: Int?
    var suppressedTail: Int?
    var shortLegs: Int?
    var wikipediaUrl: String?
    var hypoallergenic: Int?
    
    internal enum CodingKeys: String, CodingKey {
        case catDescription = "description"
        case vetstreetUrl = "vetstreet_url"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case healthIssues = "health_issues"
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case wikipediaUrl = "wikipedia_url"
        case name, temperament, origin, indoor, grooming, intelligence, vocalisation, experimental, hairless, natural, rare, rex, hypoallergenic
    }
}
