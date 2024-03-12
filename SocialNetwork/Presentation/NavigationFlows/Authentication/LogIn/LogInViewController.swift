//
//  LogInViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.1.24..
//

import UIKit

//MARK: - LogInViewController

final class LogInViewController: UIViewController, Coordinatable {
        
    typealias CoordinatorType = AuthenticationCoordinator
    var coordinator: CoordinatorType?
    
    private let viewModel: LogInViewModelProtocol
    
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
        backgroundColor: .textAndButtonColor) { [weak self] in
            self?.viewModel.updateState(viewInput: .openScreenRegistration)
        }
    
    private lazy var haveAccountButton = MainBigButton(
        title: "Уже есть аккаунт",
        font: .interRegular400Font,
        titleColor: .textAndButtonColor,
        backgroundColor: nil) { [weak self] in
            self?.viewModel.updateState(viewInput: .openScreenHaveAccount)
        }
    
    //MARK: Initial
    
    init(viewModel: LogInViewModelProtocol) {
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
        self.view.backgroundColor = .mainBackgroundColor
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: Private methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                print("initial")
            case .showOpenRegistration:
                guard let coordinator else { return }
                coordinator.navigateTo(.registration(coordinator: coordinator))
            case .showOpenHaveAccount:
                guard let coordinator else { return }
                coordinator.navigateTo(.haveAccount(coordinator: coordinator))
            }
        }
    }
    
    private func setupUI() {
        self.view.addSubview(self.uiStack)
        self.uiStack.addArrangedSubview(self.logoImage)
        self.uiStack.addArrangedSubview(self.registrationButton)
        self.uiStack.addArrangedSubview(self.haveAccountButton)
        
        NSLayoutConstraint.activate([
            self.uiStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.uiStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.logoImage.heightAnchor.constraint(equalToConstant: 300),
            self.logoImage.widthAnchor.constraint(equalToConstant: 300),

            self.registrationButton.heightAnchor.constraint(equalToConstant: 47),
            self.registrationButton.widthAnchor.constraint(equalToConstant: 300),

            self.haveAccountButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
