//
//  HomeViewModel.swift
//  MeetTheCat
//
//  Created by Sejmet on 21/11/2021.
//

import UIKit

class HomeViewModel: NSObject {

    private let homeRequestsManager: HomeRequestsManager = HomeRequestsManager()
    var cats: [Cat] = []
    var myVotedCatsIds: [String] = []
    
    func searchCats(completion: @escaping (_ success: Bool, _ errorMessage: String) -> Void) {
        homeRequestsManager.getCats { [weak self] catsArray, errorMessage in
            guard let sSelf = self else {
                completion(false, "")
                return
            }
            sSelf.cats = catsArray
            completion(catsArray.count > 0, errorMessage)
        }
    }
    
    func voteCat(cat: Cat, vote: Int) {
        homeRequestsManager.voteForCat(catId: cat.catId, vote: vote) { success, errorMessage in
            if !success {
                //should retry?
            }
        }
    }
    
    func allMyVotes() {
        homeRequestsManager.myVotedCats { [weak self] myVotedCats, errorMessage in
            guard let sSelf = self else {
                return
            }
            sSelf.myVotedCatsIds = myVotedCats.map({ cat in
                return cat.catId
            })
        }
    }
}
