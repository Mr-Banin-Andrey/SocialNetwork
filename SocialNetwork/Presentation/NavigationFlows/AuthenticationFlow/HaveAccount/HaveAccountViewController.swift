//
//  HaveAccountViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import UIKit

//MARK: - HaveAccountViewController

final class HaveAccountViewController: UIViewController, Coordinatable {
    
    typealias CoordinatorType = AuthenticationCoordinator
    var coordinator: CoordinatorType?
    
    //MARK: Properties
    
    private let viewModel: HaveAccountViewModel
    
    private lazy var mainView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private lazy var checkMarkImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .confirmationCheckMarkImage
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    private lazy var titleLabel = UILabel(text: "С возвращением", state: .logInTitleLabel)
    
    private lazy var textFieldsStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 12
        $0.backgroundColor = .clear
        return $0
    }(UIStackView())
    
    private lazy var emailTextField = CustomTextField(
        placeholder: "E-mail",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor,
        keyboardType: .emailAddress
    )
    
    private lazy var passTextField = CustomTextField(
        placeholder: "Пароль",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor,
        isSecureTextEntry: true
    )
    
    private lazy var forgotPasswordButton = CustomButton(
        title: "Забыли пароль?",
        font: .interSemiBold600Font.withSize(12),
        titleColor: .textSecondaryColor,
        backgroundColor: .clear
    ) { [weak self] in
        self?.viewModel.updateState(with: .didTapForgotPassword)
    }
        
    
    private lazy var singInButton = CustomButton(
        title: "ВОЙТИ",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textAndButtonColor
    ) { [weak self] in
        self?.viewModel.updateState(with: .didTapSignIn(email: self?.emailTextField.text ?? "", password: self?.passTextField.text ?? ""))
    }
    
    private lazy var loadingViewController = LoadingDimmingViewController()
    
    //MARK: Initial
    
    init(viewModel: HaveAccountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindViewModel()
        self.setupBackButton()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Private methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                break
            case .tryingToSignIn:
                self.loadingViewController.show(on: self)
            case .showUser(let user):
                self.loadingViewController.hide {
                    self.navigationController?.navigationBar.isHidden = true
                    self.coordinator?.proceedToUserFlow(user)
                }
            case .showAlertError:
                self.loadingViewController.hide {
                    self.presentAlert(
                        message: "Неверные логин или пароль",
                        actionTitle: "Попробовать ещё раз"
                    )
                }
            case .openScreenForgotPassword:
                guard let coordinator = coordinator else { return }
                coordinator.navigateTo(.forgotPassword(coordinator: coordinator))
            }
        }
    }
    
    private func setupBackButton() {
        let backBarButton = UIBarButtonItem(image: .arrowLeftImage, style: .plain, target: self, action: #selector(comeBack))
        backBarButton.tintColor = .textAndButtonColor
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    private func setupUI() {
        self.view.backgroundColor = .mainBackgroundColor
        
        self.view.addSubview(self.checkMarkImage)
        self.view.addSubview(self.mainView)
        self.view.addSubview(self.titleLabel)
        
        self.mainView.addSubview(self.textFieldsStack)
        self.textFieldsStack.addArrangedSubview(self.emailTextField)
        self.textFieldsStack.addArrangedSubview(self.passTextField)
        self.mainView.addSubview(self.forgotPasswordButton)
        self.mainView.addSubview(self.singInButton)
                
        NSLayoutConstraint.activate([
            
            self.mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50),
            self.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.checkMarkImage.bottomAnchor.constraint(equalTo: self.mainView.topAnchor, constant: -48),
            self.checkMarkImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.checkMarkImage.heightAnchor.constraint(equalToConstant: 86),
            self.checkMarkImage.widthAnchor.constraint(equalToConstant: 100),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
            
            self.textFieldsStack.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.textFieldsStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            self.textFieldsStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            
            self.forgotPasswordButton.topAnchor.constraint(equalTo: self.textFieldsStack.bottomAnchor, constant: 16),
            self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 16),
            self.forgotPasswordButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            
            self.singInButton.topAnchor.constraint(equalTo: self.textFieldsStack.bottomAnchor, constant: 56),
            self.singInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.singInButton.heightAnchor.constraint(equalToConstant: 48),
            self.singInButton.widthAnchor.constraint(equalToConstant: 122),
            self.singInButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -16)
        ])
    }
    
    //MARK: @objc private methods
    
    @objc private func comeBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
