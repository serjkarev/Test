//
//  RepoCell.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import UIKit

class RepoCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    var repo: Repo! {
        didSet { updateCell(repo: repo) }
    }
}

extension RepoCell {
    static func register(to tableView: UITableView) {
        let cellString = String(describing: self)
        let cellNib = UINib(nibName: cellString, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellString)
    }
    
    static var cellHeight: CGFloat = 70
}

private extension RepoCell {
    func updateCell(repo: Repo) {
        self.nameLabel.text = repo.fullName
        
    }
}
