//
//  ConfigurableCell.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/20/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    func configure(using viewModel: ConfigurableCellViewModel)
}
