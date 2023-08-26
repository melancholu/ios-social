//
//  UserCell.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import UIKit

class UserCell: BaseTableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func initView() {
        super.initView()

        self.profileImageView.image = nil
        self.nameLabel.text = ""
    }

    func display(user: User) {
        self.profileImageView.image = UIImage(named: "icUser")
        self.nameLabel.text = user.name
    }
}
