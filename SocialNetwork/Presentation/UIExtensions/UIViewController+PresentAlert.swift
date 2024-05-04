//
//  UIViewController+PresentAlert.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 4.5.24..
//

import UIKit

extension UIViewController {
    
    func presentAlert(message: String,
                      title: String? = nil,
                      actionTitle: String? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.view.tintColor = .textAndButtonColor
        let cancelAction = UIAlertAction(title: actionTitle ?? "Попробовать ещё раз", style: .default)

        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
