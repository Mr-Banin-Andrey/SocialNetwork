//
//  CommentCell.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 4.4.24..
//

import UIKit

final class CommentCell: UITableViewCell {
    
    static let reuseID = "CommentCellID"
    
    //MARK: Properties
    
    private lazy var avatarView = AvatarAssembly(size: .sizeFifteen, isBorder: false, isEdit: false).view()
    
    private lazy var nicknameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .interMedium500Font.withSize(12)
        $0.textColor = .textTertiaryColor
        $0.text = "victor.dis"
        return $0
    }(UILabel())
    
    private lazy var textCommentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .interRegular400Font.withSize(12)
        $0.textColor = .textSecondaryColor
        $0.text = "Очень интересно"
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var dateCommentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .interRegular400Font.withSize(12)
        $0.textColor = .dataCommentColor
        $0.text = "19 июля"
        return $0
    }(UILabel())
    
    private lazy var likeStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private lazy var likeImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .likeImage
        $0.tintColor = .textAndButtonColor
        $0.heightAnchor.constraint(equalToConstant: 15).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 15).isActive = true
        return $0
    }(UIImageView())
    
    private lazy var likeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "0"
        $0.textColor = .textAndButtonColor
        $0.font = .interRegular400Font.withSize(12)
        return $0
    }(UILabel())
    
    //MARK: Initial
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func setupCell(comment: CommentCodable) {
        avatarView.setupAvatar(comment.userCreatedID)
        nicknameLabel.text = comment.nickname
        textCommentLabel.text = comment.text
        dateCommentLabel.text = DateConverter.dateString(from: comment.dateCreated.dateValue())
        likeLabel.text = "\(comment.likes.count)"
    }
    
    private func setupUI() {
        contentView.addSubview(avatarView)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(textCommentLabel)
        contentView.addSubview(dateCommentLabel)
        contentView.addSubview(likeStack)
        likeStack.addArrangedSubview(likeImage)
        likeStack.addArrangedSubview(likeLabel)
        
        NSLayoutConstraint.activate([
            avatarView.heightAnchor.constraint(equalToConstant: 15),
            avatarView.widthAnchor.constraint(equalToConstant: 15),
            avatarView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            avatarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            nicknameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            nicknameLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 8),
            
            textCommentLabel.topAnchor.constraint(equalTo: self.nicknameLabel.bottomAnchor, constant: 3),
            textCommentLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 8),
            textCommentLabel.trailingAnchor.constraint(equalTo: self.likeStack.leadingAnchor, constant: -8),
            
            dateCommentLabel.topAnchor.constraint(equalTo: self.textCommentLabel.bottomAnchor),
            dateCommentLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 8),
            dateCommentLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            
            likeStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            likeStack.centerYAnchor.constraint(equalTo: self.dateCommentLabel.centerYAnchor, constant: -2),
        ])
    }
}
