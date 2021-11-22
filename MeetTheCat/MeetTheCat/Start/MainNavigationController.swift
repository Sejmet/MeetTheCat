//
//  MainNavigationController.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        viewControllers = [homeVC]
    }

}
