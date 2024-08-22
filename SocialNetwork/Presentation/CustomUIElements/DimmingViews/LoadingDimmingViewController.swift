//
//  LoadingDimmingViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.5.24..
//

import UIKit

final class LoadingDimmingViewController: DimmingViewController {
    
    // MARK: Private properties
    
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .mainBackgroundColor.withAlphaComponent(0.4)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
