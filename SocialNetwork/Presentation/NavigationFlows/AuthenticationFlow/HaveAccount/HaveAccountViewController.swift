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
    
    private lazy var registrationButton = CustomButton(
        title: "ПОДТВЕРДИТЬ",
        font: .interMedium500Font,
        titleColor: .mainBackgroundColor,
        backgroundColor: .textAndButtonColor) { [weak self] in
            self?.viewModel.updateState(with: .goToScreenMain)
        }
    
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
        self.view.backgroundColor = .mainBackgroundColor
        self.setupUI()
    }
    
    //MARK: Private methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else { return }
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
        
        self.view.addSubview(self.numberText)
        self.view.addSubview(self.registrationButton)
        
        NSLayoutConstraint.activate([
            self.titleAndExplanationStack.bottomAnchor.constraint(equalTo: self.numberText.topAnchor, constant: -100),
            self.titleAndExplanationStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleAndExplanationStack.leadingAnchor.constraint(equalTo: self.registrationButton.leadingAnchor, constant: 10),
            self.titleAndExplanationStack.trailingAnchor.constraint(equalTo: self.registrationButton.trailingAnchor, constant: -10),
            
            self.numberText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: numberText.countIndents()),
            self.numberText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -numberText.countIndents()),
            self.numberText.heightAnchor.constraint(equalToConstant: 48),
            self.numberText.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            
            self.registrationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.registrationButton.topAnchor.constraint(equalTo: self.numberText.bottomAnchor, constant: 88),
            self.registrationButton.heightAnchor.constraint(equalToConstant: 48),
            self.registrationButton.widthAnchor.constraint(equalToConstant: 261),
        ])

    }
    
    //MARK: @objc private methods
    
    @objc private func comeBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
