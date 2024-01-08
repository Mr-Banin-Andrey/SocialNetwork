//
//  RegistrationView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 8.1.24..
//

import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func goToConfirmationOfRegistration()
}

final class RegistrationView: UIView {
    
    weak var delegate: RegistrationViewDelegate?
    
    //MARK: Properties
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "ЗАРЕГИСТРИРОВАТЬСЯ"
        $0.textColor = .textColor
        $0.font = .interSemiBold600Font
        return $0
    }(UILabel())
    
    private lazy var nameNumberAndExplanationStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    private lazy var nameNumberLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var explanationLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var numberText = CustomTextField(mode: <#T##CustomTextField.Mode#>)
    
    
    
    //MARK: Initial
    
    init(delegate: RegistrationViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private methods
    
    
}
