//
//  Endpoints.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import UIKit

public enum Endpoints {
    case imagesSearch(Int)
    case allMyVotes
    case vote(String, Int)
}

public extension Endpoints {
    func resolve() -> URLRequestBuilder {
        switch self {
        case .imagesSearch(let limit):
            return CatAPI.imagesSearch(limit)
        case .allMyVotes:
            return CatAPI.allMyVotes
        case .vote(let imageId, let vote):
            return CatAPI.vote(imageId, vote)
        }
    }
}
