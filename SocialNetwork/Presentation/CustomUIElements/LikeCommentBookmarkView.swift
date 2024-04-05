//
//  LikeCommentBookmarkView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 4.4.24..
//

import UIKit

final class LikeCommentBookmarkView: UIView {
    
    //MARK: Properties
    
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
    
    private lazy var likeImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .likeImage
        $0.tintColor = .textAndButtonColor
        return $0
    }(UIImageView())
    
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
    
    private lazy var bookmarkButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .textAndButtonColor
        $0.setImage(.bookmarkImage, for: .normal)
        return $0
    }(UIButton())
    
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
    
    func setupView() {
        //TODO: данные за базы
    }
    
    private func setupUI() {
        addSubview(likeAndCommentStack)
        likeAndCommentStack.addArrangedSubview(likeStack)
        likeAndCommentStack.addArrangedSubview(commentStack)
        likeStack.addArrangedSubview(likeImage)
        likeStack.addArrangedSubview(likeLabel)
        commentStack.addArrangedSubview(commentImage)
        commentStack.addArrangedSubview(commentLabel)
        addSubview(bookmarkButton)
        
        NSLayoutConstraint.activate([
            likeAndCommentStack.topAnchor.constraint(equalTo: self.topAnchor),
            likeAndCommentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeAndCommentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            bookmarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bookmarkButton.centerYAnchor.constraint(equalTo: likeAndCommentStack.centerYAnchor)
        ])
    }
}
