//
//  Cat.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import UIKit

struct Cat: Codable {
    var catId: String
    var imageUrl: String
    var breeds: [CatBreed]?
    var categories: [CatCategory]?
    
    internal enum CodingKeys: String, CodingKey {
        case catId = "id"
        case imageUrl = "url"
        case breeds, categories
    }
}

