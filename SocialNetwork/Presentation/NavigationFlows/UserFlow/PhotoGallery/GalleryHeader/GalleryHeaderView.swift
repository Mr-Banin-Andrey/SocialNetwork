//
//  GalleryHeaderView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.4.24..
//

import UIKit

final class GalleryHeaderView: UIView {
    
    enum GalleryHeaderType {
        case album
        case photosInCollection
    }
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 3
    }
    
    //MARK: Properties
    
    private let viewModel: GalleryHeaderViewModel
    
    private lazy var firstLineView = UIView().lineView
    
    private lazy var nameTitleAndCount: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .textAndButtonColor
        $0.font = .interSemiBold600Font.withSize(14)
        return $0
    }(UILabel())
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.minimumLineSpacing = 4
        $0.minimumInteritemSpacing = 4
        $0.scrollDirection = .vertical
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseID)
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: self.layout))
    
    private var imageCount = 0
    
    private lazy var galleryType: GalleryHeaderType = .album {
        didSet {
            switch galleryType {
            case .album:
                imageCount = 1
                firstLineView.isHidden = true
                nameTitleAndCount.attributedText = StringConverter.editColor(name: "Album", count: imageCount)
                nameTitleAndCount.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
                collectionView.heightAnchor.constraint(equalToConstant: heightCollection(albumCount: imageCount)).isActive = true
                
            case .photosInCollection:
                imageCount = 8
                nameTitleAndCount.attributedText = StringConverter.editColor(name: "Photos", count: imageCount)
                nameTitleAndCount.topAnchor.constraint(equalTo: self.firstLineView.bottomAnchor, constant: 16).isActive = true
                collectionView.heightAnchor.constraint(equalToConstant: heightCollection(albumCount: imageCount)).isActive = true
            }
        }
    }
    
    //MARK: Initial
    
    init(viewModel: GalleryHeaderViewModel, galleryType: GalleryHeaderType) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupUI()
        bindViewModel()
        setupType(type: galleryType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            switch state {
            case .initial:
                break
            }
        }
    }
    
    private func setupType(type: GalleryHeaderType) {
        switch type {
        case .album:
            galleryType = .album
        case .photosInCollection:
            galleryType = .photosInCollection
        }
    }
    
    private func setupUI() {
        addSubview(firstLineView)
        addSubview(nameTitleAndCount)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            firstLineView.topAnchor.constraint(equalTo: self.topAnchor),
            firstLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            firstLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            nameTitleAndCount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            collectionView.topAnchor.constraint(equalTo: nameTitleAndCount.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }
    
    private func heightCollection(albumCount: Int) -> CGFloat {
        let lineCount = albumCount / 3
        let remainder = albumCount % 3
        let height = (UIScreen.main.bounds.width - 40) / 3
        
        if remainder == 0 {
            return (height + 4) * CGFloat(lineCount)
        } else {
            return (height + 4) * CGFloat(lineCount + 1)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension GalleryHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageCount
        //TODO: кол-во альбомов/фотографий
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseID, for: indexPath) as? PhotoCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
            return cell
        }
        //TODO: передать айди альбома/фотографии
//        cell.setupCell(userID: <#T##String#>)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension GalleryHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let wight = (UIScreen.main.bounds.width - 40) / 3
        return CGSize(width: wight, height: wight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch galleryType {
        case .album:
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell {
//            //TODO: открыть фотки альбома
            let userID = cell.getPhotoID()
//            viewModel.updateState(with: .didTapAvatar)
        }
        case .photosInCollection:
            break
        }
    }
}
