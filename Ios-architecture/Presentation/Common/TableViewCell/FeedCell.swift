//
//  FeedCell.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/12.
//

import UIKit

class FeedCell: BaseTableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func initView() {
        self.profileImageView.image = nil
        self.nameLabel.text = ""
        self.createdLabel.text = ""
        self.contentLabel.text = ""
    }

    func display(feed: Feed) {
        self.profileImageView.image = UIImage(named: "icUser")
        self.nameLabel.text = "name"
        self.createdLabel.text = feed.created
        self.contentLabel.text = feed.content
    }
}
