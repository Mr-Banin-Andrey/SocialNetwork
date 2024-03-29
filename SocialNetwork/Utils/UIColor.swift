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
    
    class var mainBackgroundColor: UIColor {
        UIColor(named: "mainBackgroundColor") ?? .white
    }
    
    class var textTertiaryColor: UIColor {
        UIColor(named: "textTertiaryColor") ?? .orange
    }
    
    // MARK: - RegistrationView
    
    class var numberTextLabelColor: UIColor {
        UIColor(named: "numberTextLabelColor") ?? .lightGray
    }
    
    // MARK: - Post
    
    class var backgroundTextColor: UIColor {
        UIColor(named: "backgroundTextColor") ?? .white
    }
    
    // MARK: - TabBar
    
    class var notSelectIconColor: UIColor {
        UIColor(named: "notSelectColor") ?? .black
    }
    
    class var selectedIconColor: UIColor {
        UIColor(named: "selectedColor") ?? .orange
    }
}
