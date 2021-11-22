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
    var cardsToBeVisible: Int = 3
    var cardViews : [CatCardView] = []
    var remainingcards: Int = 0
    
    let horizontalInset: CGFloat = 10.0
    let verticalInset: CGFloat = 10.0
    
    var visibleCards: [CatCardView] {
        return subviews as? [CatCardView] ?? []
    }
    var dataSource: SwipeCardsDataSource? {
        didSet {
            reloadData()
        }
    }
    
    var stackViewContainerDelegate: StackViewContainerProtocol?
    
    func reloadData() {
        removeAllCardViews()
        guard let datasource = dataSource else { return }
        setNeedsLayout()
        layoutIfNeeded()
        numberOfCardsToShow = datasource.numberOfCardsToShow()
        remainingcards = numberOfCardsToShow
        
        for i in 0..<min(numberOfCardsToShow, cardsToBeVisible) {
            addCardView(cardView: datasource.card(at: i), atIndex: i )
        }
    }
    
    private func addCardView(cardView: CatCardView, atIndex index: Int) {
        cardView.swipeCardDelegate = self
        addCardFrame(index: index, cardView: cardView)
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
        remainingcards -= 1
    }
    
    func addCardFrame(index: Int, cardView: CatCardView) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        let verticalInset = CGFloat(index) * self.verticalInset
        
        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset
        
        cardView.frame = cardViewFrame
    }
    
    private func removeAllCardViews() {
        for cardView in visibleCards {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }
    
    func swipeDidEnd(on view: CatCardView, liked: Bool) {
        guard let datasource = dataSource else { return }
        view.removeFromSuperview()
        
        if liked {
            stackViewContainerDelegate?.didLikeCard(card: view)
        } else {
            stackViewContainerDelegate?.didDiscardCard(card: view)
        }
        
        if remainingcards > 0 {
            let newIndex = datasource.numberOfCardsToShow() - remainingcards
            addCardView(cardView: datasource.card(at: newIndex), atIndex: 2)
            for (cardIndex, cardView) in visibleCards.reversed().enumerated() {
                UIView.animate(withDuration: 0.2, animations: {
                    cardView.center = self.center
                    self.addCardFrame(index: cardIndex, cardView: cardView)
                    self.layoutIfNeeded()
                })
            }
        } else {
            stackViewContainerDelegate?.loadMoreCats()
        }
    }
    
    func showMoreInformation(view: CatCardView) {
        stackViewContainerDelegate?.showMoreInformation(card: view)
    }
}
