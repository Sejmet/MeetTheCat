//
//  CatCardView.swift
//  MeetTheCat
//
//  Created by Sejmet on 21/11/2021.
//

import UIKit
import Kingfisher

class CatCardView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var showInformationButton: UIButton!
    @IBOutlet weak var likeOrDislikeImageView: UIImageView!
    
    var swipeCardDelegate: SwipeCardsDelegate?
    
    var divisor: CGFloat = 0
    let baseView = UIView()
    
    var dataSource: Cat? {
        didSet {
            guard let imageUrl = URL(string: dataSource?.imageUrl ?? "") else { return }
            catImageView.kf.setImage(with: imageUrl, placeholder: nil, options: nil, completionHandler: nil)
            likeOrDislikeImageView.isHidden = true
            showInformationButton.isHidden = (dataSource?.breeds?.count ?? 0) == 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("CatCardView", owner: self, options: nil)
        self.frame = contentView.frame
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.contentView)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        
        addPanGestureOnCards()
        configureTapGesture()
        roundedView.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedView.styleForCards()
    }
    
    @IBAction func didTapShowInformationButton(_ sender: UIButton) {
        swipeCardDelegate?.showMoreInformation(view: self)
    }

    func configureTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let card = sender.view as! CatCardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        
        let movingX = centerOfParentContainer.x + point.x
        let movingY = centerOfParentContainer.y + point.y
        card.center = CGPoint(x: movingX, y: movingY)
        
        let distanceFromCenterInX = centerOfParentContainer.x - card.center.x
        
        switch sender.state {
        case .ended:
            if distanceFromCenterInX > 100 {
                //Discard
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                    card.center = CGPoint(x: movingX - 200, y: movingY + 45)
                    self.layoutIfNeeded()
                } completion: { finished in
                    self.swipeCardDelegate?.swipeDidEnd(on: card, liked: false)
                }
                
                return
            } else if distanceFromCenterInX < -100 {
                //Like
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                    card.center = CGPoint(x: movingX + 200, y: movingY + 45)
                    self.layoutIfNeeded()
                } completion: { finished in
                    self.swipeCardDelegate?.swipeDidEnd(on: card, liked: true)
                }
                
                return
            }
            UIView.animate(withDuration: 0.2) {
                self.likeOrDislikeImageView.isHidden = true
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            if distanceFromCenterInX > 80 {
                likeOrDislikeImageView.isHidden = false
                likeOrDislikeImageView.image = UIImage(named: "Discard_Icon")
            } else if distanceFromCenterInX < -80 {
                likeOrDislikeImageView.isHidden = false
                likeOrDislikeImageView.image = UIImage(named: "Like_Icon")
            }
            
            let rotation = tan(point.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
        default:
            break
        }
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
    }
}
