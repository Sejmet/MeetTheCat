//
//  CatDetailViewController.swift
//  MeetTheCat
//
//  Created by Sejmet on 22/11/2021.
//

import UIKit
import Kingfisher

class CatDetailViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var detailTableView: UITableView!
    
    var catImage: String = ""
    var catBreed: CatBreed = CatBreed()
    var catDetailVM: CatDetailViewModel = CatDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail"
        loadImage()
        catDetailVM.setupCatDetail(catBreed: catBreed)
        setupTableView()
    }
    
    func loadImage() {
        guard let imageUrl = URL(string: catImage) else { return }
        catImageView.kf.setImage(with: imageUrl, placeholder: nil, options: nil, completionHandler: nil)
    }

}

/**
 Table View
 */
extension CatDetailViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    private func setupTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(UINib(nibName: "CatDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CatDetailTableViewCell")
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.estimatedRowHeight = 80
        //remove empty cells
        detailTableView.tableFooterView = nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catDetailVM.catDetailInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatDetailTableViewCell", for: indexPath) as! CatDetailTableViewCell
        cell.selectionStyle = .none
        cell.setupCell(title: catDetailVM.catDetailInformation[indexPath.row].title, subtitle: catDetailVM.catDetailInformation[indexPath.row].subtitle)
        return cell
    }
}
