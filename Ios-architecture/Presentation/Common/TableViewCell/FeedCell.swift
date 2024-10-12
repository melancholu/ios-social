//
//  FeedCell.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/12.
//

import UIKit

protocol FeedCellDelegate: AnyObject {
    func onClickLike(in cell: FeedCell)
}

class FeedCell: BaseTableViewCell {

    weak var delegate: FeedCellDelegate?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!

    override func initView() {
        super.initView()

        self.profileImageView.image = nil
        self.nameLabel.text = ""
        self.createdLabel.text = ""
        self.contentLabel.text = ""
        self.likeCountLabel.text = "0"
        self.likeButton.addTarget(self, action: #selector(onClickLike(_:)), for: UIControl.Event.touchUpInside)
    }

    func display(feed: Feed) {
        self.profileImageView.image = UIImage(named: "icUser")
        self.nameLabel.text = feed.user?.name ?? ""
        self.createdLabel.text = feed.created?.readable()
        self.contentLabel.text = feed.content
        self.likeCountLabel.text = String(feed.likes ?? 0)
        self.likeButton.setImage(feed.liked ?? false ? UIImage(named: "icLike") : UIImage(named: "icUnlike"), for: .normal)
        self.likeButton.tintColor = feed.liked ?? false ? UIColor.red : UIColor(named: "gray500")
    }

    @IBAction func onClickLike(_ sender: Any) {
        self.delegate?.onClickLike(in: self)
    }
}
