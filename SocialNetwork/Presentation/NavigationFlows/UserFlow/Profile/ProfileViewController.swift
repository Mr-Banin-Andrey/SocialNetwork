//
//  ProfileViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 17.3.24..
//

import UIKit

final class ProfileViewController: UIViewController, Coordinatable {
    
    //MARK: Properties
    
    typealias CoordinatorType = ProfileCoordinator
    var coordinator: CoordinatorType?
    
    let viewModel: ProfileViewModel
    
    //MARK: Init
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
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
