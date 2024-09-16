//
//  CommentCell.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2024/09/16.
//

import UIKit

class CommentCell: BaseTableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func initView() {
        super.initView()

        self.profileImageView.image = nil
        self.nameLabel.text = ""
        self.createdLabel.text = ""
        self.contentLabel.text = ""
    }

    func display(comment: Comment) {
        self.profileImageView.image = UIImage(named: "icUser")
        self.nameLabel.text = comment.user?.name ?? ""
        self.createdLabel.text = comment.created?.readable()
        self.contentLabel.text = comment.content
    }
}
