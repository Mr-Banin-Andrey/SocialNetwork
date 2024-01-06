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
    
    //MARK: Initial
    
    
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
        print("showRegistrationScreen")
    }
    
    func showHaveAccountScreen() {
        print("showHaveAccountScreen")
    }
    
    
}
