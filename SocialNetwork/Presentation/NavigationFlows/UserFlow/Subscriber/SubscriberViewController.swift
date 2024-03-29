//
//  SubscriberViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 29.3.24..
//

import UIKit

final class SubscriberViewController: UIViewController {
    
    //MARK: Properties
    
    let viewModel: SubscriberViewModel
    
    //MARK: Init
    
    init(viewModel: SubscriberViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
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
}
