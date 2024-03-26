//
//  SavedViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 17.3.24..
//

import UIKit

final class SavedViewController: UIViewController, Coordinatable {
    
    //MARK: Properties
    
    typealias CoordinatorType = SavedCoordinator
    var coordinator: CoordinatorType?
    
    let viewModel: SavedViewModel
    
    //MARK: Init
    
    init(viewModel: SavedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
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

