//
//  RegistrationViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 8.1.24..
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    private lazy var registrationView = RegistrationView(delegate: self)
    
    //MARK: Life cycle
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension RegistrationViewController: RegistrationViewDelegate {
    
    func goToConfirmationOfRegistration() {
        print("goToConfirmationOfRegistration")
    }
}
