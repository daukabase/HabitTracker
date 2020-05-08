//
//  UITableView.swift
//  Unicredit
//
//  Created by Maxim MAMEDOV on 21/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UITableView {

    /// Set table header view & add Auto layout.
    func setTableHeaderView(headerView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false

        // Set first.
        tableHeaderView = headerView

        // Then setup AutoLayout.
        let constraints = [
            headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            headerView.topAnchor.constraint(equalTo: self.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        updateHeaderViewFrame()
    }

    /// Update header view's frame.
    func updateHeaderViewFrame() {
        guard let headerView = self.tableHeaderView else {
            return
        }
        // Update the size of the header based on its internal content.
        headerView.layoutIfNeeded()
        // ***Trigger table view to know that header should be updated.
        let header = tableHeaderView
        tableHeaderView = header
    }
    
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        if Bundle.main.path(forResource: cellClass.identifier, ofType: "nib") != nil {
            register(UINib(nibName: cellClass.identifier, bundle: nil), forCellReuseIdentifier: cellClass.identifier)
        } else {
            register(cellClass, forCellReuseIdentifier: cellClass.identifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        self.register(T.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath) as? T else {
            fatalError("Error: cannot dequeue cell with identifier: \(cellClass.identifier) " +
                "for index path: \(indexPath)")
        }
        return cell
    }

}
