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
    
    // MARK: - TabBar
    
    class var vectorHouseNotSelectImage: UIImage {
        UIImage(named: "vectorHouseBlack") ?? UIImage()
    }
    
    class var vectorHouseSelectedImage: UIImage {
        UIImage(named: "vectorHouseOrange") ?? UIImage()
    }
    
    class var profileIconSelectedImage: UIImage {
        UIImage(named: "profileIconSelected") ?? UIImage()
    }
    
    class var profileIconNotSelectImage: UIImage {
        UIImage(named: "profileIconNotSelect") ?? UIImage()
    }
    
    class var savedIconImage: UIImage {
        UIImage(named: "savedIcon") ?? UIImage()
    }
    
}
