//
//  IconsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit


class IconsViewController: UIViewController {
    
    let spacing: CGFloat = 12
    let itemsCountForOneRow: CGFloat = 6
    
    var selectedIcon: HabitIcon {
        return icons.first { $0.isSelected }?.habitIcon ?? .meditation
    }
    
    private lazy var icons = HabitIcon.allCases.enumerated().map { (index, icon) -> IconCellViewModel in
        IconCellViewModel(isSelected: index == 0, selectedColor: color, habitIcon: icon)
    }
    private var color: UIColor = ColorName.icons.color
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.font = FontFamily.Gilroy.regular.font(size: 16)
        label.textColor = ColorName.uiOrange.color
        label.text = "Icon"
        
        return label
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        let oneRowItemsTotalSpacing = (itemsCountForOneRow - 1) * spacing
        let oneRowItemsTotalWidth = collectionView.frame.size.width - oneRowItemsTotalSpacing
        let itemWidth = Double(oneRowItemsTotalWidth / itemsCountForOneRow).rounded(.down)
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.estimatedItemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        collection.delegate = self
        collection.dataSource = self
        collection.registerCell(cellType: IconCell.self)
        collection.backgroundColor = .white
        collection.allowsMultipleSelection = false
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        view.addSubview(collectionView)
        
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview()
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(150)
            make.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.snp.updateConstraints { (make) in
            make.height.equalTo(collectionView.contentSize.height)
        }
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
    }

    func setup(color: UIColor) {
        self.color = color
        icons.forEach { (model) in
            model.selectedColor = color
        }
        collectionView.reloadData()
    }

}

extension IconsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        icons.forEach { (model) in
            model.isSelected = false
        }
        icons[indexPath.row].isSelected = true
        collectionView.reloadData()
    }
    
}

extension IconsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(cellType: IconCell.self, indexPath: indexPath) else {
            return UICollectionViewCell(frame: .zero)
        }
        
        cell.configure(model: icons[indexPath.row])
        
        return cell
    }
    
}

