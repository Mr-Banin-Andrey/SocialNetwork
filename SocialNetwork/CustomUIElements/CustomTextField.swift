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
    
    enum Mode {
        case onlyPlaceholder
        case withTitle
    }
    
    // MARK: Private properties
    
    private var edgeInsets = UIEdgeInsets()
    private var title: String?
    private var shownText: String?
    private var mode: Mode = .onlyPlaceholder
        
//    private lazy var labelTitle: UILabel = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
////        $0.textColor = .textFieldTitleLabelColor
//        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
//        $0.isHidden = true
//        $0.alpha = 0
//        return $0
//    }(UILabel())
//    
//    private lazy var errorTitle: UILabel = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
////        $0.textColor = .textFieldErrorTextColor
//        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
//        $0.isHidden = true
//        return $0
//    }(UILabel())
        
//    private let withTitle = UIEdgeInsets(top: 26, left: 12, bottom: 4, right: 12)
    private let onlyPlaceholder = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
    // MARK: Init
    
    init(
//        placeholder: String? = nil,
        text: String? = nil,
        mode: Mode,
        keyboardType: UIKeyboardType = .default
    ) {
//        self.title = titleOrPlaceholder
        self.shownText = text
        self.mode = mode
        super.init(frame: .zero)
        
        self.keyboardType = keyboardType
        self.setupMode(self.mode)
        self.setup()
        
//        IQKeyboardManager.shared.toolbarTintColor = .mainTextColor
//        IQKeyboardManager.shared.toolbarBarTintColor = .backgroundViewOrCellColor
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
    
//    func showError(text: String) {
////        self.backgroundColor = .textFieldErrorColor
//        self.errorTitle.isHidden = false
//        self.errorTitle.text = text
//    }
//    
//    func cancelError(text: String? = nil) {
////        self.backgroundColor = .textFieldBackgroundColor
//        self.errorTitle.isHidden = true
//        self.errorTitle.text = text
//    }
    
    // MARK: Private methods
    private func setupMode(_ mode: Mode) {
        switch mode {
        case .withTitle:
//            self.edgeInsets = withTitle
            self.text = shownText
//            self.labelTitle.text = title
//            self.labelTitle.isHidden = false
//            self.labelTitle.alpha = 1
        case .onlyPlaceholder:
            self.edgeInsets = onlyPlaceholder
            self.placeholder = title
        }
    }
    
    private func setup() {
//        self.addSubview(self.labelTitle)
//        self.addSubview(self.errorTitle)
//        self.setupConstraints()
        
//        self.backgroundColor = .textFieldBackgroundColor
//        self.textColor = .textFieldColor
        self.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
    }
    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            self.labelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
//            self.labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
//            
//            self.errorTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
//            self.errorTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
//        ])
//    }
    
    
    @objc private func addFloatingLabel() {
//        self.labelTitle.text = self.title
//        self.cancelError()
        if self.text == "" {
//            self.labelTitle.isHidden = false
//            self.edgeInsets = self.withTitle

            UIView.animate(withDuration: 0.4) {
//                self.labelTitle.alpha = 1
                self.placeholder = ""
            }
        }
    }
    
    @objc private func removeFloatingLabel() {
        if self.text == "" {
            self.edgeInsets = self.onlyPlaceholder
//            self.placeholder = self.labelTitle.text
//            self.labelTitle.isHidden = true
//            self.labelTitle.alpha = 0
            self.layoutIfNeeded()
            
//            self.showError(text: "Поле должно быть заполнено")
        } else {
            if self.keyboardType == .emailAddress {
                guard let text = self.text else { return }
//                if UsefulMethods().isValidEmail(text) != true {
//                    showError(text: "Неккоректная почта")
//                }
            }
        }
    }
}
