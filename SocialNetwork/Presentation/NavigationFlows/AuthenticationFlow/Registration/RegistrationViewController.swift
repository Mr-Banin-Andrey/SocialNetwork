//
//  RegistrationViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 8.1.24..
//

import UIKit

//MARK: - RegistrationViewController

final class RegistrationViewController: UIViewController, Coordinatable {
    
    //MARK: Properties
    
    private let viewModel: RegistrationViewModel
    
    typealias CoordinatorType = AuthenticationCoordinator
    var coordinator: CoordinatorType?
    
    private lazy var mainView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private lazy var titleLabel = UILabel(text: "Зарегистрироваться", state: .logInTitleLabel)
    
    private lazy var textFieldsStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 12
        $0.backgroundColor = .clear
        return $0
    }(UIStackView())
    
    private lazy var lastNameTextField = CustomTextField(
        placeholder: "Фамилия",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor
    )
    
    private lazy var firstNameTextField = CustomTextField(
        placeholder: "Имя",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor
    )
    
    private lazy var nicknameTextField = CustomTextField(
        placeholder: "Никнейм",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor
    )
    
    private lazy var emailTextField = CustomTextField(
        placeholder: "E-mail",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor,
        keyboardType: .emailAddress
    )
    
    private lazy var passTextField = CustomTextField(
        placeholder: "Пароль (от 6 до 8 символов)",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor,
        isSecureTextEntry: true
    )
    
    private lazy var repeatPassTextField = CustomTextField(
        placeholder: "Подтверждение пароля",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor,
        isSecureTextEntry: true
    )

    private lazy var confirmationButton = CustomButton(
        title: "ЗАРЕГИСТРИРОВАТЬСЯ",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textAndButtonColor
    ) { [weak self] in
        guard let self else { return }
        
        if fieldCheck() {
            viewModel.updateState(with: .didTapRegistration(
                email: emailTextField.text ?? "",
                password: passTextField.text ?? "",
                user: createUser()
            ))
        }
    }
    
    private lazy var privacyPolicyLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Нажимая кнопку “Зарегистрироваться” Вы принимаете пользовательское Соглашение и политику конфедициальности"
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
        self.setupUI()
    }
    
    //MARK: Private methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                break
            case .showUser(let user):
                navigationController?.navigationBar.isHidden = true
                self.coordinator?.proceedToUserFlow(user)
            case .showAlertFieldsEmpty:
                presentAlert(
                    message: "Все поля должны быть заполнены",
                    title: "Ошибка"
                )
            case .showAlertPasswordsDoNotMatch:
                presentAlert(
                    message: "Пароли не совпадают",
                    title: "Ошибка"
                )
            case .showAlertInvalidPassword:
                presentAlert(
                    message: "Некорректный пароль",
                    title: "Ошибка"
                )
            case .showAlertInvalidEmail:
                presentAlert(
                    message: "Некорректная почта",
                    title: "Ошибка"
                )
            }
        }
    }
    
    private func createUser() -> User {
        return User(id: "", nickname: nicknameTextField.text ?? "", firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", profession: "", following: [], followers: [], posts: [], photos: [], savedPosts: [])
    }
    
    private func fieldCheck() -> Bool {
        if lastNameTextField.text == "" ||
            firstNameTextField.text == "" ||
            nicknameTextField.text == "" ||
            emailTextField.text == "" ||
            passTextField.text == "" ||
            repeatPassTextField.text == "" {
            viewModel.updateState(with: .fieldsEmpty)
            return false
        } else {
            guard passTextField.text == repeatPassTextField.text else {
                viewModel.updateState(with: .passwordsDoNotMatch)
                return false
            }
            return true
        }
    }
    
    private func setupBackButton() {
        let backBarButton = UIBarButtonItem(image: .arrowLeftImage, style: .plain, target: self, action: #selector(comeBack))
        backBarButton.tintColor = .textAndButtonColor
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    private func setupUI() {
        self.view.backgroundColor = .mainBackgroundColor
        
        self.view.addSubview(self.mainView)
        self.view.addSubview(self.titleLabel)
        
        self.mainView.addSubview(self.textFieldsStack)
        self.textFieldsStack.addArrangedSubview(self.lastNameTextField)
        self.textFieldsStack.addArrangedSubview(self.firstNameTextField)
        self.textFieldsStack.addArrangedSubview(self.nicknameTextField)
        self.textFieldsStack.addArrangedSubview(self.emailTextField)
        self.textFieldsStack.addArrangedSubview(self.passTextField)
        self.textFieldsStack.addArrangedSubview(self.repeatPassTextField)
        self.mainView.addSubview(self.confirmationButton)
        self.mainView.addSubview(self.privacyPolicyLabel)
                
        NSLayoutConstraint.activate([

            self.mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
            
            self.textFieldsStack.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.textFieldsStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            self.textFieldsStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            
            self.confirmationButton.topAnchor.constraint(equalTo: self.textFieldsStack.bottomAnchor, constant: 48),
            self.confirmationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.confirmationButton.heightAnchor.constraint(equalToConstant: 48),
            self.confirmationButton.widthAnchor.constraint(equalToConstant: 261),
            
            self.privacyPolicyLabel.topAnchor.constraint(equalTo: self.confirmationButton.bottomAnchor, constant: 24),
            self.privacyPolicyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.privacyPolicyLabel.widthAnchor.constraint(equalToConstant: 300),
            self.privacyPolicyLabel.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -16),
        ])
    }
    
    //MARK: @objc private methods
    
    @objc private func comeBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
