//
//  BackgroundImagesViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/1/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit


final class BackgroundImagesViewController: UIViewController {
    
    private var bakcgroundImages: [UIImage] = [
        Asset.illustration1.image,
        Asset.illustration2.image,
        Asset.illustration3.image,
        Asset.illustration1.image,
        Asset.illustration2.image,
        Asset.illustration1.image,
        Asset.illustration2.image
    ]
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.font = FontFamily.Gilroy.regular.font(size: 16)
        label.textColor = ColorName.uiOrange.color
        label.text = "Choose background image"
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 91, height: 64)
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.minimumLineSpacing = 16
        flowLayout.estimatedItemSize = CGSize(width: 91, height: 64)
        flowLayout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.registerCell(cellType: BackgroundImageCell.self)
        
        return collectionView
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
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(64)
        }
        
    }
    
}


extension BackgroundImagesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bakcgroundImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: BackgroundImageCell.self, indexPath: indexPath)!
        
        cell.imageView.image = self.bakcgroundImages[indexPath.row]
        
        return cell
    }
    
}
extension BackgroundImagesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BackgroundImageCell else {
            return
        }
        cell.isSelected = true
    }
    
}
