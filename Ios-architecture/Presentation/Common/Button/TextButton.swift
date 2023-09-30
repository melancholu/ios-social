//
//  TextButton.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/30.
//

import Foundation
import UIKit

class TextButton: UIButton {
    static let identifier = "TextButton"

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
        let nib = UINib(nibName: TextButton.identifier, bundle: nil)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                UIView else {fatalError("Unable to convert nib")}

        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(view)
    }
}
