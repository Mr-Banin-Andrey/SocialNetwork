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
        case onlyPlaceholder = 0
    }
    
    // MARK: Private properties
    
    private var edgeInsets = UIEdgeInsets()
    private var mode: Mode = .onlyPlaceholder
    private var textIndentation: CGFloat = 0
        
    private let onlyPlaceholder = UIEdgeInsets(top: 11, left: 20, bottom: 11, right: 20)
    
    // MARK: Init
    
    init(
        placeholder: String? = nil,
        mode: Mode,
        borderColor: CGColor = UIColor.clear.cgColor,
        keyboardType: UIKeyboardType = .default
    ) {
        self.mode = mode
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.layer.borderColor = borderColor
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
        case .forCode:
            self.edgeInsets = countIndents()
        case .onlyPlaceholder:
            self.edgeInsets = onlyPlaceholder
        }
    }
    
    private func countIndents() -> UIEdgeInsets {
        return UIEdgeInsets(top: 14.5, left: countIndents(), bottom: 14.5, right: countIndents())
    }
    
    private func setup() {
        self.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
    }
}

extension CustomTextField: UITextFieldDelegate {
    
}
