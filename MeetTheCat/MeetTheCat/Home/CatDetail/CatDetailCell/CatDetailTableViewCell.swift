//
//  CatDetailTableViewCell.swift
//  MeetTheCat
//
//  Created by Sejmet on 22/11/2021.
//

import UIKit

class CatDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func setupCell(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
