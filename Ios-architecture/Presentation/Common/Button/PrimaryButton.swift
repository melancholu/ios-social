//
//  PrimaryButton.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/02.
//

import Foundation
import UIKit

class PrimaryButton: UIButton {
    static let identifier = "PrimaryButton"

    @IBOutlet var button: UIButton!

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initSubviews()
    }

    func initSubviews() {
        let nib = UINib(nibName: PrimaryButton.identifier, bundle: nil)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                UIView else {fatalError("Unable to convert nib")}

        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(view)
    }
}
