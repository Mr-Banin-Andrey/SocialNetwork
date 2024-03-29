//
//  UIActivityIndicatorViewExt.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import UIKit

extension UIActivityIndicatorView {
    var activityIndicator: UIActivityIndicatorView {
        self.style = .medium
        self.color = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func updateLoadingAnimation(isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}
