//
//  CustomButton.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.1.24..
//

import UIKit

final class CustomButton: UIButton {
    
    typealias Action = () -> Void
    
    //MARK: Properties
    
    private let buttonAction: Action
    private var mainColor: UIColor?
    private var title: String?
    private var forPosts: Bool?

    //MARK: Initial
    
    init(
        title: String,
        font: UIFont,
        titleColor: UIColor,
        backgroundColor: UIColor?,
        forPosts: Bool = false,
        action: @escaping Action
    ) {
        self.buttonAction = action
        self.mainColor = backgroundColor ?? .clear
        self.title = title
        self.forPosts = forPosts
        super.init(frame: .zero)

        self.setTitle(self.title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = mainColor
        self.layer.cornerRadius = 10
        
        self.translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    init(
        image: UIImage,
        tintColor: UIColor,
        action: @escaping Action
    ) {
        self.buttonAction = action
        super.init(frame: .zero)
        
        self.setImage(image, for: .normal)
        self.tintColor = tintColor
        self.translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.07, delay: 0.02, animations: {
            self.transform = CGAffineTransform(scaleX: 0.94, y: 0.93)
            self.layer.shadowOffset = CGSize(width: 2, height: 2)
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.05, delay: 0.12, animations:  {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.layer.shadowOffset = CGSize(width: 4, height: 4)
        })
    }
    
    //MARK: Public methods
    
    func underlineSwitch(isSelect: Bool) {
        guard let title = self.title else { return }
        if isSelect {
            self.setAttributedTitle(setupUnderline(text: title), for: .normal)
        } else {
            self.setAttributedTitle(setupRemoveUnderline(text: title), for: .normal)
        }
    }
    
    func changeColorAndTitle(title: String, color: UIColor?) {
        self.setTitle(title, for: .normal)
        self.mainColor = color ?? .clear
        self.backgroundColor = color
    }
    
    //MARK: Private methods
    
    private func setupUnderline(text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineColor: UIColor.textTertiaryColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.textAndButtonColor
        ]

        return NSAttributedString(string: text, attributes: attributes)
    }
    
    private func setupRemoveUnderline(text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.textSecondaryColor]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    //MARK: @objc methods
    
    @objc private func actionButton() {
        buttonAction()
    }
    
}
