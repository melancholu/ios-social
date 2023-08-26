//
//  UIColor.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/12.
//

import UIKit

extension UIColor {
    static var black: UIColor {
        return UIColor.color(name: "black")
    }
    static var gray100: UIColor {
        return UIColor.color(name: "gray100")
    }
    static var gray300: UIColor {
        return UIColor.color(name: "gray300")
    }
    static var primary: UIColor {
        return UIColor.color(name: "primary")
    }
    static var white: UIColor {
        return UIColor.color(name: "white")
    }

    private static func color(name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            return .black
        }
        return color
    }
}
