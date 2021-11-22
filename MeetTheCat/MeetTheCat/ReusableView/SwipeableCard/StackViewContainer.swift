//
//  StackViewContainer.swift
//  MeetTheCat
//
//  Created by Sejmet on 21/11/2021.
//

import UIKit

protocol StackViewContainerProtocol {
    func didLikeCard(card: CatCardView)
    func didDiscardCard(card: CatCardView)
    func loadMoreCats()
    func showMoreInformation(card: CatCardView)
}

class StackViewContainer: UIView, SwipeCardsDelegate {
    
    var numberOfCardsToShow: Int = 0
    var cardViews: [CatCardView] = []
    
    let horizontalInset: CGFloat = 10.0
    let verticalInset: CGFloat = 10.0

    var dataSource: SwipeCardsDataSource? {
        didSet {
            reloadData()
        }
    }
    
    var stackViewContainerDelegate: StackViewContainerProtocol?
    
    func reloadData() {
        guard let datasource = dataSource else { return }
        setNeedsLayout()
        layoutIfNeeded()
        numberOfCardsToShow = datasource.numberOfCardsToShow()
        
        for i in 0..<numberOfCardsToShow {
            addCardView(cardView: datasource.card(at: i), atIndex: i )
        }
    }
    
    private func addCardView(cardView: CatCardView, atIndex index: Int) {
        cardView.swipeCardDelegate = self
        cardView.frame = bounds
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
    }
    
    func swipeDidEnd(on view: CatCardView, liked: Bool) {
        view.removeFromSuperview()
        
        if liked {
            stackViewContainerDelegate?.didLikeCard(card: view)
        } else {
            stackViewContainerDelegate?.didDiscardCard(card: view)
        }
        
        cardViews.removeFirst()
        if cardViews.count == 1 {
            stackViewContainerDelegate?.loadMoreCats()
        }
    }
    
    func showMoreInformation(view: CatCardView) {
        stackViewContainerDelegate?.showMoreInformation(card: view)
    }
}
