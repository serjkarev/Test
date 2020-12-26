//
//  UIStoryboard+Extension.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import UIKit

enum Storyboard: String {
    case main
    case detail
}

extension UIStoryboard {
    static func mainViewController() -> ViewController {
        return UIStoryboard(.main).instantiateViewController(with: ViewController.self)
    }
}

private extension UIStoryboard {
    convenience init(_ storyboard: Storyboard) {
        self.init(name: storyboard.rawValue.capitalized, bundle: .main)
    }
    
    func instantiateViewController<T: UIViewController>(with class: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}
