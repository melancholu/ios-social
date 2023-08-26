//
//  Instantiable.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/05.
//

import Foundation
import UIKit

protocol StoryboardInstantiable: NSObjectProtocol {
    // swiftlint:disable:next type_name
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }

    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let vc = storyboard.instantiateViewController(withIdentifier: fileName) as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}
