//
//  UIViewExt.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 3.4.24..
//

import UIKit

extension UIView {
    var lineView: UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .textSecondaryColor
        self.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return self
    }
}
