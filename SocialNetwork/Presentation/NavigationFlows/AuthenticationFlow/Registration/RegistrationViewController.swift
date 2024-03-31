//
//  RegistrationViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 8.1.24..
//

import UIKit

//MARK: - RegistrationViewController

final class RegistrationViewController: UIViewController, Coordinatable {
    
    private let viewModel: RegistrationViewModel
    
    typealias CoordinatorType = AuthenticationCoordinator
    var coordinator: CoordinatorType?
    
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
    
    private lazy var confirmationButton = CustomButton(
        title: "ДАЛЕЕ",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textAndButtonColor) { [weak self] in
            self?.viewModel.updateState(with: .openScreenConfirmation)
        }
    
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
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackButton()
        self.bindViewModel()
        self.view.backgroundColor = .mainBackgroundColor
        self.setupUI()
    }
    
    
    //MARK: Private methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                print("initial")
            case .showOpenConfirmation:
                guard let coordinator else { return }
                coordinator.navigateTo(.confirmation(coordinator: coordinator))
            }
        }
    }
    
    private func setupBackButton() {
        let backBarButton = UIBarButtonItem(image: .arrowLeftImage, style: .plain, target: self, action: #selector(comeBack))
        backBarButton.tintColor = .textAndButtonColor
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    private func setupUI() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.nameNumberAndExplanationStack)
        self.nameNumberAndExplanationStack.addArrangedSubview(self.nameNumberLabel)
        self.nameNumberAndExplanationStack.addArrangedSubview(self.explanationLabel)
        self.view.addSubview(self.numberText)
        self.view.addSubview(self.confirmationButton)
        self.view.addSubview(self.privacyPolicyLabel)

        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.nameNumberAndExplanationStack.topAnchor, constant: -70),
            
            self.nameNumberAndExplanationStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.nameNumberAndExplanationStack.widthAnchor.constraint(equalToConstant: 215),
            self.nameNumberAndExplanationStack.bottomAnchor.constraint(equalTo: self.numberText.topAnchor, constant: -24),
            
            self.numberText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: numberText.countIndents()),
            self.numberText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -numberText.countIndents()),
            self.numberText.heightAnchor.constraint(equalToConstant: 48),
            self.numberText.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10),
            
            self.confirmationButton.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 64),
            self.confirmationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.confirmationButton.heightAnchor.constraint(equalToConstant: 48),
            self.confirmationButton.widthAnchor.constraint(equalToConstant: 120),
            
            self.privacyPolicyLabel.topAnchor.constraint(equalTo: self.confirmationButton.bottomAnchor, constant: 30),
            self.privacyPolicyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.privacyPolicyLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    //MARK: @objc private methods
    
    @objc private func comeBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
