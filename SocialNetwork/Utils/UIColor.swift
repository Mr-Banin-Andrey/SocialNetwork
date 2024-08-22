//
//  UIColor.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.1.24..
//

import UIKit

extension UIColor {
    
    // MARK: - Main
    
    class var textAndButtonColor: UIColor {
        UIColor(named: "textColor") ?? .black
    }
    
    class var textSecondaryColor: UIColor {
        UIColor(named: "textSecondaryColor") ?? .gray
    }
    
    class var textTertiaryColor: UIColor {
        UIColor(named: "textTertiaryColor") ?? .orange
    }
    
    class var mainBackgroundColor: UIColor {
        UIColor(named: "mainBackgroundColor") ?? .white
    }
    
    class var secondaryBackgroundColor: UIColor {
        UIColor(named: "secondaryBackgroundColor") ?? .white
    }
    
    // MARK: - Comment
    
    class var dataCommentColor: UIColor {
        UIColor(named: "dataCommentColor") ?? .gray
    }
    
    // MARK: - RegistrationView
    
    class var numberTextLabelColor: UIColor {
        UIColor(named: "numberTextLabelColor") ?? .lightGray
    }
    
    // MARK: - TabBar
    
    class var notSelectIconColor: UIColor {
        UIColor(named: "notSelectColor") ?? .black
    }
    
    class var selectedIconColor: UIColor {
        UIColor(named: "selectedColor") ?? .orange
    }
}
