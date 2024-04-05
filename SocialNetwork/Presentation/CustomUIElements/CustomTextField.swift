//
//  CustomTextField.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 8.1.24..
//

import UIKit
import IQKeyboardManagerSwift

// MARK: - CustomTextField

final class CustomTextField: UITextField {
    
    enum Mode: CGFloat {
        case forNumber = 165
        case forCode = 120
        case onlyPlaceholder
        case forComment
    }
    
    // MARK: Private properties
    
    private var edgeInsets = UIEdgeInsets()
    private var mode: Mode = .onlyPlaceholder
    private var textIndentation: CGFloat = 0
        
    private let onlyPlaceholder = UIEdgeInsets(top: 11, left: 20, bottom: 11, right: 20)
    
    private lazy var paperclipBackgroundView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return $0
    }(UIView())
    
    private lazy var paperclipImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 15).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 15).isActive = true
        $0.image = .paperclipImage
        $0.tintColor = .textAndButtonColor
        return $0
    }(UIImageView())
    
    // MARK: Init
    
    init(
        placeholder: String? = nil,
        mode: Mode,
        borderColor: CGColor = UIColor.clear.cgColor,
        keyboardType: UIKeyboardType = .default,
        backgroundColor: UIColor? = .clear
    ) {
        self.mode = mode
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.layer.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.setupMode(self.mode)
        self.setup()
        
        IQKeyboardManager.shared.toolbarTintColor = .textAndButtonColor
        IQKeyboardManager.shared.toolbarBarTintColor = .mainBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: edgeInsets)
    }
   
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: edgeInsets)
    }
    
    // MARK: Public methods

    func countIndents() -> CGFloat {
        let textIndentation = ((UIScreen.main.bounds.width - mode.rawValue) / 2) / 2
        return textIndentation
    }
    
    // MARK: Private methods
    
    private func setupMode(_ mode: Mode) {
        switch mode {
        case .forNumber:
            self.edgeInsets = countIndents()
            self.font = .interMedium500Font
            setupLayer()
        case .forCode:
            self.edgeInsets = countIndents()
            self.font = .interMedium500Font
            setupLayer()
        case .onlyPlaceholder:
            self.edgeInsets = onlyPlaceholder
            setupLayer() 
        case .forComment:
            paperclipBackgroundView.addSubview(paperclipImage)
            paperclipImage.centerYAnchor.constraint(equalTo: self.paperclipBackgroundView.centerYAnchor).isActive = true
            paperclipImage.leadingAnchor.constraint(equalTo: self.paperclipBackgroundView.leadingAnchor, constant: 16).isActive = true
            
            leftView = paperclipBackgroundView
            leftViewMode = .always
            if let placeholder {
                self.setupPlaceholder(placeholder)
            }
        }
    }
    
    private func setupPlaceholder(_ title: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.textSecondaryColor,
            .font: UIFont.interRegular400Font.withSize(12)
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        self.attributedPlaceholder = attributedTitle
    }
    
    private func countIndents() -> UIEdgeInsets {
        return UIEdgeInsets(top: 14.5, left: countIndents(), bottom: 14.5, right: countIndents())
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
    }
    
    private func setupLayer() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
    }
}

extension CustomTextField: UITextFieldDelegate {
    
}
