//
//  StoriesView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import UIKit

final class StoriesView: UIView {

    typealias ViewModel = StoriesViewModel
    let viewModel: ViewModel
    
    // MARK: Properties
    
    typealias CoordinatorType = MainCoordinator
    var coordinator: CoordinatorType?
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.minimumLineSpacing = 0
        $0.scrollDirection = .horizontal
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(StorieCell.self, forCellWithReuseIdentifier: StorieCell.reuseID)
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: self.layout))
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupUI()
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
            case .openScreenSubscriber(let user):
                coordinator?.subscriber(user: user)
            }
        }
    }

    private func setupUI() {
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSource

extension StoriesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.usersID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StorieCell.reuseID, for: indexPath) as? StorieCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
            return cell
        }

        cell.setupCell(userID: viewModel.usersID[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension StoriesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? StorieCell {
            guard let userID = cell.getUserID() else { return }
            
            viewModel.updateState(with: .didTapAvatar(userID))
        }
    }
}
