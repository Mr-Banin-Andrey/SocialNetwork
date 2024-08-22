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
                      actionTitle: String? = nil,
                      addSecondAction: Bool = false,
                      secondActionTitle: String? = nil,
                      completionHandler:(() -> Void)? = nil
    ) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        if addSecondAction {
            let secondButton = UIAlertAction(title: secondActionTitle, style: .cancel) { action in
                guard let completionHandler else { return }
                completionHandler()
            }
            alert.addAction(secondButton)
        }
        
        alert.view.tintColor = .textAndButtonColor
        let cancelAction = UIAlertAction(title: actionTitle ?? "Попробовать ещё раз", style: .default)
        
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
