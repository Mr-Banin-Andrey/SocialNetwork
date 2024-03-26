//
//  MainViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.3.24..
//

import UIKit

final class MainViewController: UIViewController, Coordinatable {
    
    //MARK: Properties
    
    typealias CoordinatorType = MainCoordinator
    var coordinator: CoordinatorType?
    
    let viewModel: MainViewModel
    
    //MARK: Init
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .magenta
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
