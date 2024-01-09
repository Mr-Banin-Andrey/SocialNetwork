//
//  HaveAccountViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import UIKit

//MARK: - HaveAccountViewController

final class HaveAccountViewController: UIViewController {
    
    //MARK: Properties
    
    private lazy var haveAccountView = HaveAccountView(delegate: self)
    private let viewModel: HaveAccountViewModelProtocol
    
    //MARK: Initial
    
    init(viewModel: HaveAccountViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func loadView() {
        super.loadView()
        
        view = haveAccountView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindViewModel()
        self.setupBackButton()
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

//MARK: - HaveAccountViewDelegate

extension HaveAccountViewController: HaveAccountViewDelegate {
    func goToScreenMain() {
        viewModel.updateState(viewInput: .goToScreenMain)
    }
}
