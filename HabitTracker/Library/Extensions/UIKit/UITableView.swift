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

}
