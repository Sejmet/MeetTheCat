//
//  Endpoints.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import UIKit

public enum Endpoints {
    case imagesSearch
    case allMyVotes
    case vote(String, Int)
}

public extension Endpoints {
    func resolve() -> URLRequestBuilder {
        switch self {
        case .imagesSearch:
            return CatAPI.imagesSearch
        case .allMyVotes:
            return CatAPI.allMyVotes
        case .vote(let imageId, let vote):
            return CatAPI.vote(imageId, vote)
        }
    }
}
