//
//  CatAPI.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import UIKit
import Alamofire

enum CatAPI: URLRequestBuilder {
    case imagesSearch
    case allMyVotes
    case vote(String, Int)
}

extension CatAPI {
    var path: String {
        switch self {
        case .imagesSearch:
            return APIPath.CatApi.imagesSearch
        case .allMyVotes:
            return APIPath.CatApi.votes
        case .vote:
            return APIPath.CatApi.votes
        }
    }
}

extension CatAPI {
    var parameters: Parameters? {
        switch self {
        case .imagesSearch:
            return nil
        case .allMyVotes:
            return nil
        case .vote(let imageId, let vote):
            return ["image_id": imageId,
                    "value": vote
            ]
        }
    }
}

extension CatAPI {
    var method: HTTPMethod {
        switch self {
        case .imagesSearch:
            return HTTPMethod.get
        case .allMyVotes:
            return HTTPMethod.get
        case .vote:
            return HTTPMethod.post
        }
    }
}
