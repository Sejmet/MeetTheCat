//
//  UIView+Utils.swift
//  MeetTheCat
//
//  Created by Sejmet on 21/11/2021.
//

import UIKit

extension UIView {
    
    func styleForCards() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 7
        addShadowForCards()
    }
    
    private func addShadowForCards() {
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.black.cgColor
        let rect = CGRect(x: self.bounds.minX + 3, y: self.bounds.minY + 10, width: self.bounds.width - 4, height: self.bounds.height - 8.5)
        let shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: self.layer.cornerRadius)
        self.layer.shadowPath = shadowPath.cgPath
    }
}
