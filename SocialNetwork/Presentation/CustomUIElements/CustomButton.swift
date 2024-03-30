//
//  CustomButton.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.1.24..
//

import UIKit

final class CustomButton: UIButton {
    
    typealias Action = () -> Void
    
    var buttonAction: Action
    
    init(
        title: String,
        font: UIFont,
        titleColor: UIColor,
        backgroundColor: UIColor?,
        action: @escaping Action
    ) {
        self.buttonAction = action
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
        
        addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func actionButton() {
        buttonAction()
    }
    
}
