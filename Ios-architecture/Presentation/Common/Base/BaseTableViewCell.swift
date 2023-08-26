//
//  BaseTableViewCell.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/12.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    static var identifier: String {
        return String(describing: Self.self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        initView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        initView()
    }

    func initView() {}
}
