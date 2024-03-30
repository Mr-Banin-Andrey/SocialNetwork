//
//  ProfileHeaderView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 30.3.24..
//

import UIKit

final class ProfileHeaderView: UIView {
    
    enum TypeView {
        case profileView
        case subscriberView
    }
    
    private let viewModel: ProfileHeaderViewModel
    
    //MARK: Properties
    
    private lazy var avatarImage = AvatarAssembly(size: .sizeEighty, isBorder: false).view()
    
    private lazy var nameAndProfessionStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .leading
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    private lazy var nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Ivanka Pushkin"
        $0.textColor = .textAndButtonColor
        $0.font = .interSemiBold600Font
        return $0
    }(UILabel())
    
    private lazy var professionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Policmen"
        $0.textColor = .textSecondaryColor
        $0.font = .interRegular400Font
        return $0
    }(UILabel())
    
    private lazy var editButton = CustomButton(
        title: "Подписаться",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textAndButtonColor// .textTertiaryColor
    ) { [weak self] in
        return
    }
    
    private lazy var firstLineView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .textSecondaryColor
        $0.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return $0
    }(UIView())

    private lazy var infoSubscribersAndPublicationStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 24
        return $0
    }(UIStackView())
    
    private lazy var publicationsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .textTertiaryColor
        $0.numberOfLines = 2
        $0.font = .interRegular400Font
        $0.text = "1400\nпубликаций"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var followingLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .textAndButtonColor
        $0.numberOfLines = 2
        $0.font = .interRegular400Font
        $0.text = "245\nподписок"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var followersLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .textSecondaryColor
        $0.numberOfLines = 2
        $0.font = .interRegular400Font
        $0.text = "780\nподписчиков"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var secondLineView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .textSecondaryColor
        $0.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return $0
    }(UIView())
    
    private lazy var photoLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .textAndButtonColor
        $0.font = .interRegular400Font
        return $0
    }(UILabel())
    
    private lazy var chevronImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .textAndButtonColor
        return $0
    }(UIImageView())
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.minimumLineSpacing = 0
        $0.scrollDirection = .horizontal
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(ProfileHeaderCollectionCell.self, forCellWithReuseIdentifier: ProfileHeaderCollectionCell.reuseID)
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: self.layout))
        
    private lazy var backgroundMyNotesView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .backgroundTextColor
        return $0
    }(UIView())
    
    private lazy var myNotesLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .textTertiaryColor
        $0.font = .interMedium500Font
        $0.text = "Посты Иванки"
        return $0
    }(UILabel())
    
    private lazy var createPostButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        $0.tintColor = .textAndButtonColor
        return $0
    }(UIButton())
    
    
    private var type: TypeView = .profileView {
        didSet{
            switch type {
            case .profileView:
                break
            case .subscriberView:
                break
            }
        }
    }
    
    //MARK: Initial
    
    init(viewModel: ProfileHeaderViewModel, type: TypeView) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.setupUI()
        setupImage(type: type)
        bindViewModel()
        createPostButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func setupHeader() {
        photoLabel.attributedText = editColor(count: 20)
    }
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
            }
        }
    }
    
    private func setupImage(type: TypeView) {
        switch type {
        case .profileView:
            self.type = .profileView
        case .subscriberView:
            self.type = .subscriberView
        }
    }
    
    private func editColor(count: Int) ->  NSMutableAttributedString {
        let text = "Фотографии  \(count)"
        let underlineAttributedString = NSMutableAttributedString(string: text)
        var range = (text as NSString).range(of: "\(count)")
        underlineAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.textSecondaryColor, range: range)
        return underlineAttributedString
    }
    
    private func setupUI() {
        addSubview(avatarImage)
        addSubview(nameAndProfessionStack)
        nameAndProfessionStack.addArrangedSubview(nameLabel)
        nameAndProfessionStack.addArrangedSubview(professionLabel)
        addSubview(editButton)
        addSubview(infoSubscribersAndPublicationStack)
        infoSubscribersAndPublicationStack.addArrangedSubview(publicationsLabel)
        infoSubscribersAndPublicationStack.addArrangedSubview(followingLabel)
        infoSubscribersAndPublicationStack.addArrangedSubview(followersLabel)
        addSubview(secondLineView)
        addSubview(photoLabel)
        addSubview(chevronImage)
        addSubview(collectionView)
        addSubview(backgroundMyNotesView)
        addSubview(myNotesLabel)
        addSubview(createPostButton)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            
            nameAndProfessionStack.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -8),
            nameAndProfessionStack.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 16),

            editButton.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 16),
            editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            editButton.heightAnchor.constraint(equalToConstant: 47),
            
            infoSubscribersAndPublicationStack.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 16),
            infoSubscribersAndPublicationStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            infoSubscribersAndPublicationStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            secondLineView.topAnchor.constraint(equalTo: infoSubscribersAndPublicationStack.bottomAnchor, constant: 16),
            secondLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            secondLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
          
            photoLabel.topAnchor.constraint(equalTo: secondLineView.bottomAnchor, constant: 24),
            photoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            chevronImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            chevronImage.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 68),
            collectionView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            backgroundMyNotesView.heightAnchor.constraint(equalToConstant: 40),
            backgroundMyNotesView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            backgroundMyNotesView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundMyNotesView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundMyNotesView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            myNotesLabel.centerYAnchor.constraint(equalTo: backgroundMyNotesView.centerYAnchor),
            myNotesLabel.leadingAnchor.constraint(equalTo: backgroundMyNotesView.leadingAnchor, constant: 16),
            
            createPostButton.centerYAnchor.constraint(equalTo: backgroundMyNotesView.centerYAnchor),
            createPostButton.trailingAnchor.constraint(equalTo: backgroundMyNotesView.trailingAnchor, constant: -16),
        ])
    }
}

//MARK: - UICollectionViewDataSource

extension ProfileHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileHeaderCollectionCell.reuseID, for: indexPath) as? ProfileHeaderCollectionCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
            return cell
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: 66)
    }
}
