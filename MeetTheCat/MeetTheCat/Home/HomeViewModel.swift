//
//  HomeViewModel.swift
//  MeetTheCat
//
//  Created by Sejmet on 21/11/2021.
//

import UIKit

protocol HomeViewModel {
    func loadCats(completion: @escaping (_ success: Bool, _ errorMessage: String) -> Void)
    func voteCat(cat: Cat, vote: Int)
    
    var cats: [Cat] { get }
}

class HomeViewModelImplementation: HomeViewModel {

    var cats: [Cat] = []
    private let homeRequestsManager: HomeRequestsManager = HomeRequestsManager()
    private var myVotedCatsIds: [String] = []
    
    func loadCats(completion: @escaping (_ success: Bool, _ errorMessage: String) -> Void) {
        allMyVotes { [weak self] errorMessage in
            guard let sSelf = self else {
                completion(false, "")
                return
            }
            if errorMessage == "" {
                sSelf.searchCats(completion: completion)
            } else {
                completion(false, errorMessage)
            }
        }
    }
    
    func voteCat(cat: Cat, vote: Int) {
        homeRequestsManager.voteForCat(catId: cat.catId, vote: vote) { success, errorMessage in
            if !success {
                //should retry?
            }
        }
    }
    
    private func searchCats(completion: @escaping (_ success: Bool, _ errorMessage: String) -> Void) {
        homeRequestsManager.getCats { [weak self] catsArray, errorMessage in
            guard let sSelf = self else {
                completion(false, "")
                return
            }
            sSelf.cats = catsArray.filter({ cat in
                return !(sSelf.myVotedCatsIds.contains(cat.catId))
            })
            completion(catsArray.count > 0, errorMessage)
        }
    }
    
    private func allMyVotes(completion: @escaping (_ errorMessage: String) -> Void) {
        homeRequestsManager.myVotedCats { [weak self] myVotedCats, errorMessage in
            guard let sSelf = self else {
                return
            }
            sSelf.myVotedCatsIds = myVotedCats.map({ history in
                return history.imageId
            })
            completion(errorMessage)
        }
    }
}
