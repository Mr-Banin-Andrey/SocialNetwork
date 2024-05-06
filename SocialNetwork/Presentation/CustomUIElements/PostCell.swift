//
//  PostCell.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 29.3.24..
//

import UIKit

protocol PostCellDelegate: AnyObject {
    func openScreenSubscriber(userID: String)
    func openScreenMenuSheet(post: Post)
    func openScreenWholePost(post: Post)
}

final class PostCell: UITableViewCell {
    
    static let reuseID = "PostCellID"
    
    weak var delegate: PostCellDelegate?
    
    //MARK: Properties

    private lazy var avatarView = AvatarAssembly(size: .sizeSixty, isBorder: false).view()
    
    private lazy var nameButton = CustomButton(
        title: "Ivanka Pushkin",
        font: .interMedium500Font,
        titleColor: .textAndButtonColor,
        backgroundColor: .clear
    ) { [weak self] in
        self?.delegate?.openScreenSubscriber(userID: self?.postInCell?.userCreatedID ?? "")
    }
    
    private lazy var professionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .textSecondaryColor
        $0.font = .interRegular400Font
        return $0
    }(UILabel())
        
    private lazy var verticalEllipseButton = CustomButton(
        image: .verticalEllipseImage,
        tintColor: .textTertiaryColor
    ) { [weak self] in
        guard let post = self?.postInCell else {return }
        self?.delegate?.openScreenMenuSheet(post: post)
    }
        
    private lazy var backgroundTextView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .secondaryBackgroundColor
        return $0
    }(UIView())
    
    private lazy var verticalLineView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 1).isActive = true
        $0.backgroundColor = .textAndButtonColor
        return $0
    }(UIView())
    
    private lazy var textOfPostLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .textAndButtonColor
        $0.font = .interRegular400Font
        $0.numberOfLines = 4
        $0.lineBreakMode = .byWordWrapping
        return $0
    }(UILabel())

    private lazy var showInFullButton = CustomButton(
        title: "Показать полностью...",
        font: .interSemiBold600Font.withSize(12),
        titleColor: .textSecondaryColor,
        backgroundColor: .clear
    ) { [weak self] in
        guard let post = self?.postInCell else {return }
        self?.delegate?.openScreenWholePost(post: post)
    }
    
    private lazy var pictureImage = PhotoAssembly().view()
    
    private lazy var horizontalLineView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        $0.backgroundColor = .textSecondaryColor
        return $0
    }(UIView())
    
    private lazy var likeCommentBookmarkView = LikeCommentBookmarkView()
    
    private var postInCell: Post?
    
    //MARK: Initial
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupUI()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func setupCell(post: Post) {
        avatarView.setupAvatar(post.userCreatedID)
        nameButton.setTitle("\(post.firstName) \(post.lastName)", for: .normal)
        professionLabel.text = post.profession
        textOfPostLabel.text = post.text
        pictureImage.setupPhoto(post.id)
        self.postInCell = post
        likeCommentBookmarkView.setupView(post: post)
    }
    
    func setupCellForUser() {
        nameButton.isEnabled = false
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnSubscriber))
        avatarView.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        contentView.addSubview(avatarView)
        contentView.addSubview(nameButton)
        contentView.addSubview(professionLabel)
        contentView.addSubview(verticalEllipseButton)
        contentView.addSubview(backgroundTextView)
        contentView.addSubview(verticalLineView)
        contentView.addSubview(textOfPostLabel)
        contentView.addSubview(showInFullButton)
        contentView.addSubview(pictureImage)
        contentView.addSubview(horizontalLineView)
        contentView.addSubview(likeCommentBookmarkView)
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            avatarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            avatarView.heightAnchor.constraint(equalToConstant: 60),
            avatarView.widthAnchor.constraint(equalToConstant: 60),
            
            nameButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 18),
            nameButton.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 16),
            nameButton.heightAnchor.constraint(equalToConstant: 24),
            
            professionLabel.topAnchor.constraint(equalTo: self.nameButton.bottomAnchor, constant: 6),
            professionLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 16),
            
            verticalEllipseButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            verticalEllipseButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            
            backgroundTextView.heightAnchor.constraint(equalToConstant: 308),
            backgroundTextView.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 12),
            backgroundTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            backgroundTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            backgroundTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            
            verticalLineView.topAnchor.constraint(equalTo: self.backgroundTextView.topAnchor, constant: 16),
            verticalLineView.leadingAnchor.constraint(equalTo: self.backgroundTextView.leadingAnchor, constant: 20),
            verticalLineView.bottomAnchor.constraint(equalTo: self.backgroundTextView.bottomAnchor, constant: -63),
            
            textOfPostLabel.topAnchor.constraint(equalTo: self.backgroundTextView.topAnchor, constant: 10),
            textOfPostLabel.leadingAnchor.constraint(equalTo: self.verticalLineView.trailingAnchor, constant: 26),
            textOfPostLabel.trailingAnchor.constraint(equalTo: self.backgroundTextView.trailingAnchor, constant: -16),
            textOfPostLabel.heightAnchor.constraint(equalToConstant: 82),
            
            showInFullButton.topAnchor.constraint(equalTo: self.textOfPostLabel.bottomAnchor),
            showInFullButton.leadingAnchor.constraint(equalTo: self.verticalLineView.trailingAnchor, constant: 26),
            showInFullButton.heightAnchor.constraint(equalToConstant: 15),
            
            pictureImage.heightAnchor.constraint(equalToConstant: 125),
            pictureImage.topAnchor.constraint(equalTo: self.showInFullButton.bottomAnchor, constant: 15),
            pictureImage.leadingAnchor.constraint(equalTo: self.verticalLineView.trailingAnchor, constant: 26),
            pictureImage.trailingAnchor.constraint(equalTo: self.backgroundTextView.trailingAnchor, constant: -16),
            
            horizontalLineView.topAnchor.constraint(equalTo: self.pictureImage.bottomAnchor, constant: 10),
            horizontalLineView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            horizontalLineView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            likeCommentBookmarkView.topAnchor.constraint(equalTo: horizontalLineView.bottomAnchor, constant: 14),
            likeCommentBookmarkView.leadingAnchor.constraint(equalTo: self.verticalLineView.trailingAnchor, constant: 30),
            likeCommentBookmarkView.trailingAnchor.constraint(equalTo: self.backgroundTextView.trailingAnchor, constant: -16),
        ])
    }
    
    @objc private func didTapOnSubscriber() {
        guard let userCreatedID = self.postInCell?.userCreatedID else { return }
        delegate?.openScreenSubscriber(userID: userCreatedID)
    }
}
