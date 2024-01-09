//
//  RegistrationView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 8.1.24..
//

import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func showConfirmationOfRegistration()
}

final class RegistrationView: UIView {
    
    weak var delegate: RegistrationViewDelegate?
    
    //MARK: Properties
    
    private lazy var titleLabel = UILabel(text: "Зарегистрироваться", state: .logInTitleLabel)
    
    private lazy var nameNumberAndExplanationStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private lazy var nameNumberLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Введите номер"
        $0.font = .interMedium500Font
        $0.textColor = .numberTextLabelColor
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var explanationLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Ваш номер будет использоваться для входа в аккаунт"
        $0.font = .interMedium500Font.withSize(12)
        $0.textColor = .textSecondaryColor
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var numberText = CustomTextField(
        placeholder: "+385 _ _ _ -_ _ _-_ _",
        mode: .forNumber,
        borderColor: UIColor.textAndButtonColor.cgColor,
        keyboardType: .phonePad
    )
    
    private lazy var confirmationButton = MainBigButton(
        title: "ДАЛЕЕ",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textAndButtonColor,
        action: goToConfirmationOfRegistration
    )
    
    private lazy var privacyPolicyLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Нажимая кнопку “Далее” Вы принимаете пользовательское Соглашение и политику конфедициальности"
        $0.font = .interMedium500Font.withSize(12)
        $0.textColor = .textSecondaryColor
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    //MARK: Initial
    
    init(delegate: RegistrationViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        self.backgroundColor = .mainBackgroundColor
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private methods
    
    private func setupUI() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.nameNumberAndExplanationStack)
        self.nameNumberAndExplanationStack.addArrangedSubview(self.nameNumberLabel)
        self.nameNumberAndExplanationStack.addArrangedSubview(self.explanationLabel)
        self.addSubview(self.numberText)
        self.addSubview(self.confirmationButton)
        self.addSubview(self.privacyPolicyLabel)

        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.nameNumberAndExplanationStack.topAnchor, constant: -70),
            
            self.nameNumberAndExplanationStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.nameNumberAndExplanationStack.widthAnchor.constraint(equalToConstant: 215),
            self.nameNumberAndExplanationStack.bottomAnchor.constraint(equalTo: self.numberText.topAnchor, constant: -24),
            
            self.numberText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: numberText.countIndents()),
            self.numberText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -numberText.countIndents()),
            self.numberText.heightAnchor.constraint(equalToConstant: 48),
            self.numberText.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            
            self.confirmationButton.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 64),
            self.confirmationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.confirmationButton.heightAnchor.constraint(equalToConstant: 48),
            self.confirmationButton.widthAnchor.constraint(equalToConstant: 120),
            
            self.privacyPolicyLabel.topAnchor.constraint(equalTo: self.confirmationButton.bottomAnchor, constant: 30),
            self.privacyPolicyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.privacyPolicyLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    //MARK: @objc private methods
    
    @objc private func goToConfirmationOfRegistration() {
        delegate?.showConfirmationOfRegistration()
    }
}
