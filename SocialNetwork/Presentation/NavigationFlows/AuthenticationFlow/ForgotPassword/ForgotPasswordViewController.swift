//
//  ForgotPasswordViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.5.24..
//

import UIKit

//MARK: - ForgotPasswordViewController

final class ForgotPasswordViewController: UIViewController, Coordinatable {

    typealias CoordinatorType = AuthenticationCoordinator
    var coordinator: CoordinatorType?

    //MARK: Properties

    private let viewModel: ForgotPasswordViewModel

    private lazy var mainView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UIView())

    private lazy var titleLabel = UILabel(text: "Восстановление пароля", state: .logInTitleLabel)

    private lazy var emailTextField = CustomTextField(
        placeholder: "E-mail",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor,
        keyboardType: .emailAddress
    )

    private lazy var passwordRecoveryButton = CustomButton(
        title: "Восстановить",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textAndButtonColor
    ) { [weak self] in
        self?.viewModel.updateState(with: .didTapPasswordRecovery(self?.emailTextField.text ?? ""))
    }

    private lazy var checkMarkImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .confirmationCheckMarkImage
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())


    //MARK: Initial

    init(viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupBackButton()
        setupUI()
        bindViewModel()
    }

    //MARK: Private methods

    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
            case .showAlertSuccess:
                presentAlert(
                    message: "Ссылка на восстановление пароля отправлена на почту",
                    actionTitle: "Хорошо"
                )
            case .showAlertFailed:
                presentAlert(
                    message: "Ошибка в восстановлении почты",
                    actionTitle: "Попробовать ещё раз"
                )
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
        self.mainView.addSubview(self.titleLabel)
        
        self.mainView.addSubview(emailTextField)
        self.mainView.addSubview(self.passwordRecoveryButton)
                
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
            
            self.emailTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.emailTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            self.emailTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            
            self.passwordRecoveryButton.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 24),
            self.passwordRecoveryButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.passwordRecoveryButton.heightAnchor.constraint(equalToConstant: 48),
            self.passwordRecoveryButton.widthAnchor.constraint(equalToConstant: 140),
            self.passwordRecoveryButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -16)
        ])
    }
    //MARK: @objc private methods

    @objc private func comeBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
