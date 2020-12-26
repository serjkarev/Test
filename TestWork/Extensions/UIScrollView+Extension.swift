//
//  UIScrollView+Extension.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import UIKit

extension UITableView {
    func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
