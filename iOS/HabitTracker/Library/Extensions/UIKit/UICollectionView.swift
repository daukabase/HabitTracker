//
//  UICollectionView.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 28/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UICollectionView {

    func registerCell<Cell: UICollectionViewCell>(cellType: Cell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }

    func dequeueCell<Cell: UICollectionViewCell>(cellType: Cell.Type, indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell
    }

}
