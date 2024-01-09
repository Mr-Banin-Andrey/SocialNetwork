//
//  UIImage.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.1.24..
//

import UIKit

extension UIImage {
    
    // MARK: - LogIn
    
    class var logInLogoImage: UIImage {
        UIImage(named: "logInLogo") ?? UIImage()
    }
    
    // MARK: - Confirmation
    
    class var confirmationCheckMarkImage: UIImage {
        UIImage(named: "confirmationCheckMark") ?? UIImage()
    }
    
}
