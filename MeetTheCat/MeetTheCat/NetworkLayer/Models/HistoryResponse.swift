//
//  HistoryResponse.swift
//  MeetTheCat
//
//  Created by Sejmet on 22/11/2021.
//

import UIKit

struct HistoryResponse: Codable {
    var imageId: String
    var vote: Int
    
    internal enum CodingKeys: String, CodingKey {
        case imageId = "image_id"
        case vote = "value"
    }
}
