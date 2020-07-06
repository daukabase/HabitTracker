//
//  SelectImagesViewController.swift
//  HabitTracker
//
//  Created by Daulet on 6/16/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import Photos
import YPImagePicker

final class SelectImagesViewController: UIViewController {
    
    // MARK: - Properties
    private var selectedItems: [YPMediaItem] = []
    
    // MARK: - Views
    private lazy var config: YPImagePickerConfiguration = {
        var config = YPImagePickerConfiguration()
        
        // General
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = true
        config.usesFrontCamera = false
        config.showsPhotoFilters = true
        config.showsVideoTrimmer = true
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "DefaultYPImagePickerAlbumName"
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.library, .photo]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        config.bottomMenuItemSelectedTextColour = ColorName.uiOrange.color
        config.bottomMenuItemUnSelectedTextColour = ColorName.textBlack.color
        config.maxCameraZoomFactor = 1.0
        
        // Library
        config.library.options = nil
        config.library.onlySquare = false
        config.library.isSquareByDefault = true
        config.library.minWidthForItem = nil
        config.library.mediaType = YPlibraryMediaType.photo
        config.library.defaultMultipleSelection = false
        config.library.maxNumberOfItems = 4
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 4
        config.library.spacingBetweenItems = 1.0
        config.library.skipSelectionsGallery = false
        config.library.preselectedItems = nil
        
        // Video
        config.video.compression = AVAssetExportPresetHighestQuality
        config.video.fileType = .mov
        config.video.recordingTimeLimit = 60.0
        config.video.libraryTimeLimit = 60.0
        config.video.minimumTimeLimit = 3.0
        config.video.trimmerMaxDuration = 60.0
        config.video.trimmerMinDuration = 3.0
        
        // Gallery
        config.gallery.hidesRemoveButton = false
        
        // Localization
        config.wordings.libraryTitle = "Gallery"
        config.wordings.cameraTitle = "Camera"
        config.wordings.next = "OK"
        
        return config
    }()
    
    private lazy var picker: YPImagePicker = {
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking(completion: didFinishPicking(items:cancelled:))
        
        return picker
    }()
    
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Private Methods
    private func didFinishPicking(items: [YPMediaItem], cancelled: Bool) {
        for item in items {
            switch item {
            case .photo(let photo):
                print(photo)
            case .video(let video):
                print(video)
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}


extension SelectImagesViewController: UICollectionViewDelegate {

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AddImageCell else {
            return
        }
        UIView.animate(withDuration: 0.5,
                       animations: {
                           cell.alpha = 0.5
           }) { (completed) in
               UIView.animate(withDuration: 0.5,
                              animations: {
                               cell.alpha = 1
               })
           }
        showPicker()
    }

}

extension SelectImagesViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedItems.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard selectedItems.indices ~= indexPath.row else {
            return collectionView.dequeueCell(cellType: AddImageCell.self, indexPath: indexPath) ?? UICollectionViewCell()
        }
        
        guard let cell = collectionView.dequeueCell(cellType: SelectImageCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.onDelete = { [weak self, indexPath] in
            print("deleting at: \(indexPath)")
            guard
                let self = self,
                (self.selectedItems.indices ~= indexPath.row)
            else {
                return
            }
            
            self.selectedItems.remove(at: indexPath.row)
            
            
            self.collectionView.performBatchUpdates({
                self.collectionView.deleteItems(at: [indexPath])
            }, completion: { _ in
                self.collectionView.reloadData()
            })
            
        }
        cell.configure(image: selectedItems[indexPath.row].image)
        
        return cell
    }
    
}


private extension SelectImagesViewController {
    
    // MARK: - Private Methods
    func showPicker() {
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [weak self, weak picker] (items, cancelled) in
            self?.confiugre(items: items)
            
            picker?.dismiss(animated: true, completion: nil)
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func confiugre(items: [YPMediaItem]) {
        for item in items {
            switch item {
            case .photo(let photo):
                print(photo)
            case .video(let video):
                print(video)
            }
        }
        add(new: items)
    }
    
    func add(new items: [YPMediaItem]) {
        selectedItems.append(contentsOf: items)
        collectionView.reloadData()
    }

}

fileprivate extension YPMediaItem {
    
    var image: UIImage? {
        switch self {
        case .video(let video):
            return video.thumbnail
        case .photo(let photo):
            return photo.image
        }
    }
    
}
