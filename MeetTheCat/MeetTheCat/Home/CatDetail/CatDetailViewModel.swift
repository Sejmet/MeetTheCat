//
//  CatDetailViewModel.swift
//  MeetTheCat
//
//  Created by Sejmet on 22/11/2021.
//

import UIKit

struct CatDetailCell {
    var title: String
    var subtitle: String
}

class CatDetailViewModel: NSObject {

    var catDetailInformation: [CatDetailCell] = []

    func setupCatDetail(catBreed: CatBreed) {
        catDetailInformation = []
        
        catDetailInformation.append(CatDetailCell(title: "Breed Name", subtitle: catBreed.name ?? ""))
        catDetailInformation.append(CatDetailCell(title: "Breed Description", subtitle: catBreed.catDescription ?? ""))
        catDetailInformation.append(CatDetailCell(title: "Origin", subtitle: catBreed.origin ?? ""))
        catDetailInformation.append(CatDetailCell(title: "Temperament", subtitle: catBreed.temperament ?? ""))
        catDetailInformation.append(CatDetailCell(title: "Child Friendly", subtitle: catBreed.getLevel(level: catBreed.childFriendly)))
        catDetailInformation.append(CatDetailCell(title: "Dog Friendly", subtitle: catBreed.getLevel(level: catBreed.dogFriendly)))
        catDetailInformation.append(CatDetailCell(title: "Energy Level", subtitle: catBreed.getLevel(level: catBreed.energyLevel)))
        catDetailInformation.append(CatDetailCell(title: "Grooming", subtitle: catBreed.getLevel(level: catBreed.grooming)))
        catDetailInformation.append(CatDetailCell(title: "Health Issues", subtitle: catBreed.getLevel(level: catBreed.healthIssues)))
        catDetailInformation.append(CatDetailCell(title: "Intelligence", subtitle: catBreed.getLevel(level: catBreed.intelligence)))
        catDetailInformation.append(CatDetailCell(title: "Shedding Level", subtitle: catBreed.getLevel(level: catBreed.sheddingLevel)))
        catDetailInformation.append(CatDetailCell(title: "Social Needs", subtitle: catBreed.getLevel(level: catBreed.socialNeeds)))
        catDetailInformation.append(CatDetailCell(title: "Vocalisation", subtitle: catBreed.getLevel(level: catBreed.vocalisation)))
        catDetailInformation.append(CatDetailCell(title: "Indoor", subtitle: "\(catBreed.isIndoor)".capitalized))
        catDetailInformation.append(CatDetailCell(title: "Hairless", subtitle: "\(catBreed.isHairless)".capitalized))
        catDetailInformation.append(CatDetailCell(title: "Experimental", subtitle: "\(catBreed.isExperimental)".capitalized))
        catDetailInformation.append(CatDetailCell(title: "Natural", subtitle: "\(catBreed.isNatural)".capitalized))
        catDetailInformation.append(CatDetailCell(title: "Rare", subtitle: "\(catBreed.isRare)".capitalized))
        catDetailInformation.append(CatDetailCell(title: "Suppressed Tail", subtitle: "\(catBreed.isSuppressedTail)".capitalized))
        catDetailInformation.append(CatDetailCell(title: "Rex", subtitle: "\(catBreed.isRex)".capitalized))
        catDetailInformation.append(CatDetailCell(title: "Short Legs", subtitle: "\(catBreed.isShortLegs)".capitalized))
        catDetailInformation.append(CatDetailCell(title: "Hypoallergenic", subtitle: "\(catBreed.isHypoallergenic)".capitalized))
        
    }
}
