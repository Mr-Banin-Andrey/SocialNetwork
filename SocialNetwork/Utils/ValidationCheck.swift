//
//  ValidationCheck.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 4.5.24..
//

import Foundation

final class ValidationCheck {
    
    class func emailCheck(_ email: String) -> Bool {
        guard email.count >= 8 else {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    class func passwordCheck(_ password: String) -> Bool {
        guard password.count >= 6 else {
            return false
        }
        
        guard password.count < 9 else {
            return false
        }
        
        guard !password.contains(" ") else {
            return false
        }
        
        return true
    }
}
