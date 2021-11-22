//
//  CatBreed.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import UIKit

enum Level: Int, Codable {
    case bad = 1
    case regular
    case good
    case veryGood
    case excelent
}

struct CatBreed: Codable {
    var name: String?
    var catDescription: String?
    var temperament: String?
    var origin: String?
    var childFriendly: Level?
    var dogFriendly: Level?
    var energyLevel: Level?
    var grooming: Level?
    var healthIssues: Level?
    var intelligence: Level?
    var sheddingLevel: Level?
    var socialNeeds: Level?
    var strangerFriendly: Level?
    var vocalisation: Level?
    var indoor: Int?
    var experimental: Int?
    var hairless: Int?
    var natural: Int?
    var rare: Int?
    var rex: Int?
    var suppressedTail: Int?
    var shortLegs: Int?
    var hypoallergenic: Int?
    
    var isIndoor: Bool {
        return Bool(truncating: (indoor ?? 0) as NSNumber)
    }
    var isExperimental: Bool {
        return Bool(truncating: (experimental ?? 0) as NSNumber)
    }
    var isHairless: Bool {
        return Bool(truncating: (hairless ?? 0) as NSNumber)
    }
    var isNatural: Bool {
        return Bool(truncating: (natural ?? 0) as NSNumber)
    }
    var isRare: Bool {
        return Bool(truncating: (rare ?? 0) as NSNumber)
    }
    var isRex: Bool {
        return Bool(truncating: (rex ?? 0) as NSNumber)
    }
    var isSuppressedTail: Bool {
        return Bool(truncating: (suppressedTail ?? 0) as NSNumber)
    }
    var isShortLegs: Bool {
        return Bool(truncating: (shortLegs ?? 0) as NSNumber)
    }
    var isHypoallergenic: Bool {
        return Bool(truncating: (hypoallergenic ?? 0) as NSNumber)
    }
    
    internal enum CodingKeys: String, CodingKey {
        case catDescription = "description"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case healthIssues = "health_issues"
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case name, temperament, origin, indoor, grooming, intelligence, vocalisation, experimental, hairless, natural, rare, rex, hypoallergenic
    }
    
    func getLevel(level: Level?) -> String {
        switch level {
        case .bad:
            return "Very Low"
        case .regular:
            return "Low"
        case .good:
            return "Medium"
        case .veryGood:
            return "High"
        case .excelent:
            return "Very High"
        case .none:
            return "Unknown"
        }
    }
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label: String?, value: Any) -> (String, Any)? in
            guard let label = label else { return nil }
            return (label, value)
        }).compactMap { $0 })
        return dict
    }
}
