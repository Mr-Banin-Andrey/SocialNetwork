//
//  LikeCommentBookmarkView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 4.4.24..
//

import UIKit

protocol LikeCommentBookmarkViewDelegate: AnyObject {
    func didTapLike()
}

final class LikeCommentBookmarkView: UIView {
    
    weak var delegate: LikeCommentBookmarkViewDelegate?
    
    //MARK: Properties
    
    private var post: Post?
    
    private lazy var likeAndCommentStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 30
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private lazy var likeStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private lazy var likeImageButton = CustomButton(
        image: .likeImage,
        tintColor: .textAndButtonColor
    ) { [weak self] in
        if self?.post?.likePost == false {
            self?.delegate?.didTapLike()
        }
    }
    
    private lazy var likeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "40"
        $0.textColor = .textAndButtonColor
        $0.font = .interRegular400Font
        return $0
    }(UILabel())
    
    private lazy var commentStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private lazy var commentImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .commentImage
        $0.tintColor = .textAndButtonColor
        return $0
    }(UIImageView())
    
    private lazy var commentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "40"
        $0.textColor = .textAndButtonColor
        $0.font = .interRegular400Font
        return $0
    }(UILabel())
    
    private lazy var bookmarkImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .bookmarkImage
        $0.tintColor = .textAndButtonColor
        return $0
    }(UIImageView())
    
    //MARK: Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func setupView(post: Post) {
        self.post = post
        likeLabel.text = "\(post.likes.count)"
        commentLabel.text = "\(post.comments.count)"
        changeBookmark(isSaved: post.savedPost)
        likeImageButton.updateState(isLike: post.likePost)
    }
    
    private func changeBookmark(isSaved: Bool) {
        if isSaved {
            bookmarkImage.tintColor = .textTertiaryColor
            bookmarkImage.image = .bookmarkFillImage
        } else {
            bookmarkImage.tintColor = .textAndButtonColor
            bookmarkImage.image = .bookmarkImage
        }
    }
    
    private func setupUI() {
        addSubview(likeAndCommentStack)
        likeAndCommentStack.addArrangedSubview(likeStack)
        likeAndCommentStack.addArrangedSubview(commentStack)
        likeStack.addArrangedSubview(likeImageButton)
        likeStack.addArrangedSubview(likeLabel)
        commentStack.addArrangedSubview(commentImage)
        commentStack.addArrangedSubview(commentLabel)
        addSubview(bookmarkImage)
        
        NSLayoutConstraint.activate([
            likeAndCommentStack.topAnchor.constraint(equalTo: self.topAnchor),
            likeAndCommentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeAndCommentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            bookmarkImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bookmarkImage.centerYAnchor.constraint(equalTo: likeAndCommentStack.centerYAnchor)
        ])
    }
}
