//
//  ConfirmationView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import UIKit

//MARK: - ConfirmationViewDelegate

protocol ConfirmationViewDelegate: AnyObject {
    func registrationOnSocialNetwork()
}

//MARK: - ConfirmationView

final class ConfirmationView: UIView {
    
    weak var delegate: ConfirmationViewDelegate?
    
    //MARK: Properties
    
    private lazy var titleAndExplanationStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private lazy var titleLabel = UILabel(text: "Подтверждение регистрации", state: .logInTitleLabel)
    
    private lazy var explanationLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Мы отправили SMS с кодом на номер \n +38 099 999 99 99 "
        $0.font = .interRegular400Font
        $0.textColor = .textAndButtonColor
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var codText = CustomTextField(
        placeholder: "_ _ _ -_ _ _-_ _ ",
        mode: .forCode,
        borderColor: UIColor.textAndButtonColor.cgColor
    )
    
    private lazy var registrationButton = MainBigButton(
        title: "ЗАРЕГИСТРИРОВАТЬСЯ",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textAndButtonColor,
        action: goToMainScreen
    )
    
    private lazy var checkMarkImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .confirmationCheckMarkImage
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    //MARK: Initial
    
    init(delegate: ConfirmationViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        self.backgroundColor = .mainBackgroundColor
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public methods
    
    
    
    //MARK: Private methods
    
    private func setupUI() {
        self.addSubview(self.titleAndExplanationStack)
        self.titleAndExplanationStack.addArrangedSubview(self.titleLabel)
        self.titleAndExplanationStack.addArrangedSubview(self.explanationLabel)
        
        self.addSubview(self.codText)
        self.addSubview(self.registrationButton)
        self.addSubview(self.checkMarkImage)
        
        NSLayoutConstraint.activate([
            self.titleAndExplanationStack.bottomAnchor.constraint(equalTo: self.codText.topAnchor, constant: -100),
            self.titleAndExplanationStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.codText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: codText.countIndents()),
            self.codText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -codText.countIndents()),
            self.codText.heightAnchor.constraint(equalToConstant: 48),
            self.codText.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            self.registrationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.registrationButton.topAnchor.constraint(equalTo: self.codText.bottomAnchor, constant: 88),
            self.registrationButton.heightAnchor.constraint(equalToConstant: 48),
            self.registrationButton.widthAnchor.constraint(equalToConstant: 261),
            
            self.checkMarkImage.topAnchor.constraint(equalTo: self.registrationButton.bottomAnchor, constant: 48),
            self.checkMarkImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.checkMarkImage.heightAnchor.constraint(equalToConstant: 86),
            self.checkMarkImage.widthAnchor.constraint(equalToConstant: 100),
        ])

    }
    
    @objc private func goToMainScreen() {
        delegate?.registrationOnSocialNetwork()
    }
}
