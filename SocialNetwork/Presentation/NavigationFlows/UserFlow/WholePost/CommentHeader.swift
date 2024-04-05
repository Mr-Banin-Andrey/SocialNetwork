//
//  CommentHeader.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 4.4.24..
//

import UIKit

final class CommentHeader: UIView {
    
    //MARK: Properties
    
    private lazy var avatarImage = AvatarAssembly(size: .sizeThirty, isBorder: false).view()
    
    private lazy var nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .interMedium500Font.withSize(12)
        $0.textColor = .textTertiaryColor
        $0.text = "victor.dis"
        return $0
    }(UILabel())
    
    private lazy var professionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .interRegular400Font.withSize(12)
        $0.textColor = .textSecondaryColor
        $0.text = "трубочист"
        return $0
    }(UILabel())
    
    private lazy var photoImage = PhotoAssembly().view()
    
    private lazy var commentTextLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "With prototyping in Figma, you can create multiple flows for your prototype in one page to preview a user's full journey and experience through your designs. A flow is a path users take through the network of connected frames that make up your prototype. For example, you can create a prototype for a shopping app that includes a flow for account creation, another for browsing items, and another for the checkout process–all in one page. \n\nWhen you add a connection between two frames with no existing connections in your prototype, a flow starting point is created. You can create multiple flows using the same network of connected frames by adding different flow starting points."
        $0.font = .interRegular400Font
        $0.textColor = .textAndButtonColor
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var likeCommentBookmarkView = LikeCommentBookmarkView()
    private lazy var secondLineView = UIView().lineView
    
    private lazy var commentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Комментарии:"
        $0.textColor = .textSecondaryColor
        $0.font = .interRegular400Font
        return $0
    }(UILabel())
    
    //MARK: Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    private func setupUI() {
        addSubview(avatarImage)
        addSubview(nameLabel)
        addSubview(professionLabel)
        addSubview(photoImage)
        addSubview(commentTextLabel)
        addSubview(likeCommentBookmarkView)
        addSubview(secondLineView)
        addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            avatarImage.heightAnchor.constraint(equalToConstant: 30),
            avatarImage.widthAnchor.constraint(equalToConstant: 30),
            avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            nameLabel.topAnchor.constraint(equalTo: self.avatarImage.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 16),
            
            professionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            professionLabel.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 16),
            
            photoImage.topAnchor.constraint(equalTo: self.avatarImage.bottomAnchor, constant: 16),
            photoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            photoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            photoImage.heightAnchor.constraint(equalToConstant: 212),
            
            commentTextLabel.topAnchor.constraint(equalTo: self.photoImage.bottomAnchor, constant: 16),
            commentTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            commentTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            likeCommentBookmarkView.topAnchor.constraint(equalTo: self.commentTextLabel.bottomAnchor, constant: 16),
            likeCommentBookmarkView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            likeCommentBookmarkView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            secondLineView.topAnchor.constraint(equalTo: likeCommentBookmarkView.bottomAnchor, constant: 16),
            secondLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            secondLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            commentLabel.topAnchor.constraint(equalTo: secondLineView.bottomAnchor, constant: 16),
            commentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
