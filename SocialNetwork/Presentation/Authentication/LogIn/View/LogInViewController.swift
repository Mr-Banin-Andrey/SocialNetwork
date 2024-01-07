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
