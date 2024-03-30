//
//  ConfirmationViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import UIKit

//MARK: - ConfirmationViewController

final class ConfirmationViewController: UIViewController, Coordinatable {
    
    typealias CoordinatorType = AuthenticationCoordinator
    var coordinator: CoordinatorType?
    
    //MARK: Properties
    
    private let viewModel: ConfirmationViewModel
    
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
    
    private lazy var registrationButton = CustomButton(
        title: "ЗАРЕГИСТРИРОВАТЬСЯ",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textAndButtonColor) { [weak self] in
            self?.viewModel.updateState(with: .registrationOnSocialNetwork)
        }
    
    private lazy var checkMarkImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .confirmationCheckMarkImage
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    
    //MARK: Initial
    
    init(viewModel: ConfirmationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainBackgroundColor
        self.bindViewModel()
        self.setupBackButton()
        setupUI()
    }
    
    //MARK: Private methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
            case .showUser:
                self.coordinator?.stopUserFlow()
            }
        }
    }
    
    private func setupBackButton() {
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(comeBack))
        backBarButton.tintColor = .textAndButtonColor
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    private func setupUI() {
        self.view.addSubview(self.titleAndExplanationStack)
        self.titleAndExplanationStack.addArrangedSubview(self.titleLabel)
        self.titleAndExplanationStack.addArrangedSubview(self.explanationLabel)
        
        view.addSubview(self.codText)
        view.addSubview(self.registrationButton)
        view.addSubview(self.checkMarkImage)
        
        NSLayoutConstraint.activate([
            self.titleAndExplanationStack.bottomAnchor.constraint(equalTo: self.codText.topAnchor, constant: -100),
            self.titleAndExplanationStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            self.codText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: codText.countIndents()),
            self.codText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -codText.countIndents()),
            self.codText.heightAnchor.constraint(equalToConstant: 48),
            self.codText.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            
            self.registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.registrationButton.topAnchor.constraint(equalTo: self.codText.bottomAnchor, constant: 88),
            self.registrationButton.heightAnchor.constraint(equalToConstant: 48),
            self.registrationButton.widthAnchor.constraint(equalToConstant: 261),
            
            self.checkMarkImage.topAnchor.constraint(equalTo: self.registrationButton.bottomAnchor, constant: 48),
            self.checkMarkImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.checkMarkImage.heightAnchor.constraint(equalToConstant: 86),
            self.checkMarkImage.widthAnchor.constraint(equalToConstant: 100),
        ])

    }
    
    //MARK: @objc private methods
    
    @objc private func comeBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
