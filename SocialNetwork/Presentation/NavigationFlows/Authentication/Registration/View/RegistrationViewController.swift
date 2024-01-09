//
//  RegistrationViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 8.1.24..
//

import UIKit

//MARK: - RegistrationViewController

final class RegistrationViewController: UIViewController {
    
    private lazy var registrationView = RegistrationView(delegate: self)
    private let viewModel: RegistrationViewModelProtocol
    
    weak var coordinator: RootCoordinator?
    
    //MARK: Initial
    
    init(viewModel: RegistrationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func loadView() {
        super.loadView()
        
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackButton()
        self.bindViewModel()
    }
    
    //MARK: Private methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                print("initial")
            }
        }
    }
    
    private func setupBackButton() {
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(comeBack))
        backBarButton.tintColor = .textAndButtonColor
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    //MARK: @objc private methods
    
    @objc private func comeBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - RegistrationViewDelegate

extension RegistrationViewController: RegistrationViewDelegate {
    func showConfirmationOfRegistration() {
        viewModel.updateState(viewInput: .openScreenConfirmation)
    }
}
