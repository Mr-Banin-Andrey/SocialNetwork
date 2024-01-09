//
//  LogInViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.1.24..
//

import UIKit

//MARK: - LogInViewController

final class LogInViewController: UIViewController {
    
    //MARK: Properties
    
    private lazy var logInView = LogInView(delegate: self)
    private let viewModel: LogInViewModelProtocol
    
    //MARK: Initial
    
    init(viewModel: LogInViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func loadView() {
        super.loadView()
        
        view = logInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindViewModel()
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

            }
        }
    }
}

//MARK: - LogInViewDelegate

extension LogInViewController: LogInViewDelegate {
    func showRegistrationScreen() {
        viewModel.updateState(viewInput: .openScreenRegistration)
    }
    
    func showHaveAccountScreen() {
        viewModel.updateState(viewInput: .openScreenHaveAccount)
    }
}
