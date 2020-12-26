//
//  UITableView+Extension.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import UIKit

extension UITableView {
    func register<T: UITableViewHeaderFooterView>(type: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: type)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as! T
    }
}
