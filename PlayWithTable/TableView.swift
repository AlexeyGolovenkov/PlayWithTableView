//
//  TableView.swift
//  PlayWithTable
//
//  Created by Alexey Golovenkov on 27.10.2022.
//

import UIKit

class TableView: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            updateOffset()
        }
    }
    
    // Make cells appearing from bottom
    func updateOffset() {
        let height = max(0, bounds.size.height - contentSize.height)
        guard height != contentInset.top else {
            return
        }
        self.contentInset.top = height
        setContentOffset(.init(x: 0, y: contentSize.height), animated: true)
    }
}
