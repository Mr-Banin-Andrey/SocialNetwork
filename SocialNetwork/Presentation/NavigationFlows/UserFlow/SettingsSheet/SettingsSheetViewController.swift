//
//  SettingsSheetViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 12.4.24..
//

import UIKit

final class SettingsSheetViewController: UIViewController {
    
    //MARK: Properties
    
    private let viewModel: SettingsSheetViewModel
    
    private lazy var grabberView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
        $0.layer.cornerRadius = 2
        $0.backgroundColor = .textAndButtonColor
        return $0
    }(UIView())
    
    private lazy var buttonsStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .leading
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private lazy var savedButton = CustomButton(
        title: "Сохранить в закладках",
        font: .interRegular400Font,
        titleColor: .textAndButtonColor,
        backgroundColor: nil
    ) { [weak self] in
        return
    }
    
    private lazy var unsubscribedButton = CustomButton(
        title: "Отменить подписку",
        font: .interRegular400Font,
        titleColor: .textAndButtonColor, 
        backgroundColor: nil
    ) { [weak self] in
        return
    }
    
    //MARK: Init
    
    init(viewModel: SettingsSheetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sheetPresentationController()
        setupUI()
        bindViewModel()
    }
    
    //MARK: Methods
    
    func bindViewModel() {
//        viewModel.onStateDidChange = { [weak self] state in
//            guard let self else { return}
//
//            switch state {
//            case .initial:
//                break
//            }
//        }
    }
    
    private func sheetPresentationController() {
        if let sheet = sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom { _ in
                        return 100
                    }]
            } else {
                sheet.detents = [.medium()]
            }
            sheet.prefersGrabberVisible = false
            sheet.preferredCornerRadius = 20
            sheet.largestUndimmedDetentIdentifier = .medium
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .secondaryBackgroundColor
        
        view.addSubview(grabberView)
        view.addSubview(buttonsStack)
        buttonsStack.addArrangedSubview(unsubscribedButton)
        buttonsStack.addArrangedSubview(savedButton)
        
        NSLayoutConstraint.activate([
            grabberView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            grabberView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            grabberView.widthAnchor.constraint(equalToConstant: 50),
            
            buttonsStack.topAnchor.constraint(equalTo: self.grabberView.bottomAnchor, constant: 20),
            buttonsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            buttonsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            buttonsStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
