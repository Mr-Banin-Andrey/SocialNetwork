//
//  UILabel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import UIKit

extension UILabel {
    
    enum State {
        case logInTitleLabel
    }
    
    convenience init(text: String, state: State) {
        self.init(frame: .zero)
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch state {
        case .logInTitleLabel:
            self.textColor = .textTertiaryColor
            self.font = .interSemiBold600Font
        }
        
    }
}
