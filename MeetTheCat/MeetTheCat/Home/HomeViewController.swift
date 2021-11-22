//
//  HomeViewController.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var catsImagesStackContainer: StackViewContainer!
    @IBOutlet weak var loadingView: UIView!
    
    var homeVM: HomeViewModel = HomeViewModelImplementation()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meet The Cat"
        loadCats()
        catsImagesStackContainer.dataSource = self
        catsImagesStackContainer.stackViewContainerDelegate = self
    }
    
    func loadCats() {
        loadingView.isHidden = false
        homeVM.loadCats { [weak self] (success: Bool, errorMessage: String) in
            guard let sSelf = self else {
                return
            }
            sSelf.loadingView.isHidden = true
            if success {
                sSelf.catsImagesStackContainer.reloadData()
            } else {
                sSelf.showAlert(message: errorMessage)
            }
        }
    }
    
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

/**
 Stack View Container Protocol
 */
extension HomeViewController: StackViewContainerProtocol {
    func didLikeCard(card: CatCardView) {
        guard let cat = card.dataSource else {
            return
        }
        homeVM.voteCat(cat: cat, vote: 1)
    }
    
    func didDiscardCard(card: CatCardView) {
        guard let cat = card.dataSource else {
            return
        }
        homeVM.voteCat(cat: cat, vote: 0)
    }
    
    func loadMoreCats() {
        loadCats()
    }
    
    func showMoreInformation(card: CatCardView) {
        let detailVC = CatDetailViewController()
        detailVC.catBreed = card.dataSource?.breeds?.first ?? CatBreed()
        detailVC.catImage = card.dataSource?.imageUrl ?? ""
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

/**
 Swipe Cards Data Source
 */
extension HomeViewController: SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int {
        return homeVM.cats.count
    }
    
    func card(at index: Int) -> CatCardView {
        let card = CatCardView()
        card.dataSource = homeVM.cats[index]
        return card
    }
}
