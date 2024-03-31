//
//  PostCell.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 29.3.24..
//

import UIKit

protocol PostCellDelegate: AnyObject {
    func openScreenSubscriber()
    func openScreenMenuSheet()
    func openScreenWholePost()
    func addPostToSaved()
}

final class PostCell: UITableViewCell {
    
    static let reuseID = "PostCellID"
    
    weak var delegate: PostCellDelegate?
    
    //MARK: Properties

    private lazy var avatarView = AvatarAssembly(size: .sizeSixty, isBorder: false).view()
    
    private lazy var nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Ivanka Pushkin"
        $0.textColor = .textAndButtonColor
        $0.font = .interMedium500Font
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnSubscriber))
        $0.addGestureRecognizer(tapGesture)
        $0.isUserInteractionEnabled = true
        return $0
    }(UILabel())
    
    private lazy var professionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Policmen"
        $0.textColor = .textSecondaryColor
        $0.font = .interRegular400Font
        return $0
    }(UILabel())
    
    private lazy var verticalEllipseButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(.verticalEllipseImage, for: .normal)
        $0.tintColor = .textTertiaryColor
        $0.addTarget(self, action: #selector(didTapOnMenuSheet), for: .touchUpInside)
        return $0
    }(UIButton())
        
    
    private lazy var backgroundTextView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .backgroundTextColor
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
        $0.text = "With prototyping in Figma, you can create multiple flows for your prototype in one page to preview a user's full journey and experience through your designs. A flow is a path users take through the network of connected frames that make up your prototype. For example, you can create a prototype for a shopping app that includes a flow for account creation, another for browsing items, and another for the checkout process–all in one page. When you add a connection between two frames with no existing connections in your prototype, a flow starting point is created. You can create multiple flows using the same network of connected frames by adding different flow starting points."
        $0.textColor = .textAndButtonColor
        $0.font = .interRegular400Font
        $0.numberOfLines = 4
        $0.lineBreakMode = .byWordWrapping
        return $0
    }(UILabel())

    private lazy var showInFullButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Показать полностью...", for: .normal)
        $0.titleLabel?.font = .interSemiBold600Font.withSize(12)
        $0.setTitleColor(.textSecondaryColor, for: .normal)
        $0.addTarget(nil, action: #selector(didTapText), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var pictureImage = PhotoAssembly().view()
    
    private lazy var horizontalLineView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        $0.backgroundColor = .textSecondaryColor
        return $0
    }(UIView())
    
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
        $0.addTarget(self, action: #selector(didTapOnBookmark), for: .touchUpInside)
        return $0
    }(UIButton())
    
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
    
    
    func setupCell() {
        //TODO: прокинуть данные из базы
//        avatarView.setupAvatar(<#T##userID: String##String#>)
//        nameLabel.text =
//        professionLabel.text =
//        textOfPostLabel.text =
//        pictureImage.setupPhoto(<#T##photoID: String##String#>)
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnSubscriber))
        avatarView.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(professionLabel)
        contentView.addSubview(verticalEllipseButton)
        contentView.addSubview(backgroundTextView)
        contentView.addSubview(verticalLineView)
        contentView.addSubview(textOfPostLabel)
        contentView.addSubview(showInFullButton)
        contentView.addSubview(pictureImage)
        contentView.addSubview(horizontalLineView)
        contentView.addSubview(likeAndCommentStack)
        likeAndCommentStack.addArrangedSubview(likeStack)
        likeAndCommentStack.addArrangedSubview(commentStack)
        likeStack.addArrangedSubview(likeImage)
        likeStack.addArrangedSubview(likeLabel)
        commentStack.addArrangedSubview(commentImage)
        commentStack.addArrangedSubview(commentLabel)
        contentView.addSubview(bookmarkButton)
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            avatarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            avatarView.heightAnchor.constraint(equalToConstant: 60),
            avatarView.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 18),
            nameLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 16),
            
            professionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 6),
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
            
            likeAndCommentStack.topAnchor.constraint(equalTo: horizontalLineView.bottomAnchor, constant: 14),
            likeAndCommentStack.leadingAnchor.constraint(equalTo: self.verticalLineView.trailingAnchor, constant: 30),
            
            bookmarkButton.topAnchor.constraint(equalTo: horizontalLineView.bottomAnchor, constant: 14),
            bookmarkButton.trailingAnchor.constraint(equalTo: self.backgroundTextView.trailingAnchor, constant: -16),
        ])
    }
    
    @objc private func didTapOnSubscriber() {
        delegate?.openScreenSubscriber()
    }
    
    @objc private func didTapOnMenuSheet() {
        delegate?.openScreenMenuSheet()
    }
    
    @objc private func didTapText() {
        delegate?.openScreenWholePost()
    }
    
    @objc private func didTapOnBookmark(_ sender: UIButton) {
        bookmarkButton.setImage(.bookmarkFillImage, for: .normal)
        bookmarkButton.tintColor = .textTertiaryColor

        delegate?.addPostToSaved()
    }
}
