//
//  LogInView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.1.24..
//

import UIKit

//MARK: - LogInViewDelegate

protocol LogInViewDelegate: AnyObject {
    func showRegistrationScreen()
    func showHaveAccountScreen()
}

//MARK: - LogInView

final class LogInView: UIView {
    
    weak var delegate: LogInViewDelegate?
    
    //MARK: Properties
    
    private lazy var uiStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 40
        return $0
    }(UIStackView())
    
    private lazy var logoImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .logInLogoImage
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    private lazy var registrationButton = MainBigButton(
        title: "ЗАРЕГИСТРИРОВАТЬСЯ",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textColor,
        action: goToRegistrationScreen
    )
    
    private lazy var haveAccountButton = MainBigButton(
        title: "Уже есть аккаунт",
        font: .interRegular400Font,
        titleColor: .textColor,
        backgroundColor: nil,
        action: goToHaveAccountScreen
    )
    
    //MARK: Initial
    
    init(delegate: LogInViewDelegate) {
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
        self.addSubview(self.uiStack)
        self.uiStack.addArrangedSubview(self.logoImage)
        self.uiStack.addArrangedSubview(self.registrationButton)
        self.uiStack.addArrangedSubview(self.haveAccountButton)
        
        NSLayoutConstraint.activate([
            self.uiStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.uiStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.logoImage.heightAnchor.constraint(equalToConstant: 300),
            self.logoImage.widthAnchor.constraint(equalToConstant: 300),

            self.registrationButton.heightAnchor.constraint(equalToConstant: 47),
            self.registrationButton.widthAnchor.constraint(equalToConstant: 300),

            self.haveAccountButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc private func goToRegistrationScreen() {
        delegate?.showRegistrationScreen()
    }
    
    @objc private func goToHaveAccountScreen() {
        delegate?.showHaveAccountScreen()
    }
}
