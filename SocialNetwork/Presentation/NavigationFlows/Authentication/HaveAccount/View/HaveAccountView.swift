//
//  HaveAccountView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//


import UIKit

//MARK: - HaveAccountViewDelegate

protocol HaveAccountViewDelegate: AnyObject {
    func goToScreenMain()
}

//MARK: - HaveAccountView

final class HaveAccountView: UIView {
    
    weak var delegate: HaveAccountViewDelegate?
    
    //MARK: Properties
    
    private lazy var titleAndExplanationStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 24
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private lazy var titleLabel = UILabel(text: "С возвращением", state: .logInTitleLabel)
    
    private lazy var explanationLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Введите номер телефона для входа в приложение"
        $0.font = .interRegular400Font
        $0.textColor = .textAndButtonColor
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
    
    private lazy var registrationButton = MainBigButton(
        title: "ПОДТВЕРДИТЬ",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textAndButtonColor,
        action: goToMainScreen
    )
    
    //MARK: Initial
    
    init(delegate: HaveAccountViewDelegate) {
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
        
        self.addSubview(self.numberText)
        self.addSubview(self.registrationButton)
        
        NSLayoutConstraint.activate([
            self.titleAndExplanationStack.bottomAnchor.constraint(equalTo: self.numberText.topAnchor, constant: -100),
            self.titleAndExplanationStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleAndExplanationStack.leadingAnchor.constraint(equalTo: self.registrationButton.leadingAnchor, constant: 10),
            self.titleAndExplanationStack.trailingAnchor.constraint(equalTo: self.registrationButton.trailingAnchor, constant: -10),
            
            self.numberText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: numberText.countIndents()),
            self.numberText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -numberText.countIndents()),
            self.numberText.heightAnchor.constraint(equalToConstant: 48),
            self.numberText.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            self.registrationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.registrationButton.topAnchor.constraint(equalTo: self.numberText.bottomAnchor, constant: 88),
            self.registrationButton.heightAnchor.constraint(equalToConstant: 48),
            self.registrationButton.widthAnchor.constraint(equalToConstant: 261),
        ])

    }
    
    @objc private func goToMainScreen() {
        delegate?.goToScreenMain()
    }
}
