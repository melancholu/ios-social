//
//  String.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/12.
//

import Foundation
import UIKit

extension String {
    func width(font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func readable() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions.insert(.withFractionalSeconds)

        guard let date = isoFormatter.date(from: self) else { return self }

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium

        return formatter.string(from: date)
    }
}
