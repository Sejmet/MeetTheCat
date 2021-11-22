//
//  SwipeCardsDataSource.swift
//  MeetTheCat
//
//  Created by Sejmet on 21/11/2021.
//

import UIKit

protocol SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> CatCardView  
}

protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: CatCardView, liked: Bool)
}
