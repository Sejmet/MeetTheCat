//
//  HomeRequestsManager.swift
//  MeetTheCat
//
//  Created by Sejmet on 21/11/2021.
//

import UIKit
import Alamofire

class HomeRequestsManager: NSObject {

    private let networkService: NetworkService = NetworkService()
    private let modelFactory: ModelFactory = ModelFactory()
    
    public func getCats(completion: @escaping (_ cats: [Cat], _ errorMessage: String) -> Void) {
        networkService.execute(Endpoints.imagesSearch(10).resolve()) { (dataResponse: AFDataResponse?, error: AFError?) in
            guard let response = dataResponse else {
                completion([], "")
                return
            }
            let result = self.manageResponseForCats(dataResponse: response)
            completion(result.0, result.1)
        }
    }
    
    public func voteForCat(catId: String, vote: Int, completion: @escaping (_ success: Bool, _ errorMessage: String) -> Void) {
        networkService.execute(Endpoints.vote(catId, vote).resolve()) { (dataResponse: AFDataResponse?, error: AFError?) in
            guard let response = dataResponse else {
                completion(false, "")
                return
            }
            let result = self.manageResponseForEmptyResponseData(dataResponse: response)
            completion(result.0, result.1)
        }
    }
    
    public func myVotedCats(completion: @escaping (_ myVotedCats: [HistoryResponse], _ errorMessage: String) -> Void) {
        networkService.execute(Endpoints.allMyVotes.resolve()) { (dataResponse: AFDataResponse?, error: AFError?) in
            guard let response = dataResponse else {
                completion([], "")
                return
            }
            let result = self.manageResponseVotedCats(dataResponse: response)
            completion(result.0, result.1)
        }
    }
}

/**
 Manage Response
 */
extension HomeRequestsManager {
    private func manageResponseForCats(dataResponse: AFDataResponse<Any>) -> ([Cat], String) {
        switch dataResponse.result {
        case .success(let response):
            guard let responseDic = response as? [NSDictionary] else {
                return ([], "")
            }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: responseDic, options: .prettyPrinted)
                if let catArray = self.modelFactory.makeCatArray(json: jsonData) {
                    return (catArray, "")
                }
            } catch {
                return ([], "")
            }
        case .failure(let error):
            guard let data = dataResponse.data, let errorResponse = self.modelFactory.makeErrorResponse(json: data) else {
                return ([], error.localizedDescription)
            }
            return ([], errorResponse.message ?? "")
        }
        
        return ([], "")
    }
    
    private func manageResponseVotedCats(dataResponse: AFDataResponse<Any>) -> ([HistoryResponse], String) {
        switch dataResponse.result {
        case .success(let response):
            guard let responseDic = response as? [NSDictionary] else {
                return ([], "")
            }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: responseDic, options: .prettyPrinted)
                if let history = self.modelFactory.makeHistoryResponseArray(json: jsonData) {
                    return (history, "")
                }
            } catch {
                return ([], "")
            }
        case .failure(let error):
            guard let data = dataResponse.data, let errorResponse = self.modelFactory.makeErrorResponse(json: data) else {
                return ([], error.localizedDescription)
            }
            return ([], errorResponse.message ?? "")
        }
        
        return ([], "")
    }
    
    private func manageResponseForEmptyResponseData(dataResponse: AFDataResponse<Any>) -> (Bool, String) {
        switch dataResponse.result {
        case .success(_):
            return(true, "")
        case .failure(let error):
            guard let data = dataResponse.data, let errorResponse = self.modelFactory.makeErrorResponse(json: data) else {
                if dataResponse.response?.statusCode == 200 {
                    return (true, error.localizedDescription)
                } else {
                    return (false, error.localizedDescription)
                }
            }
            return (false, errorResponse.message ?? "")
        }
    }
}
