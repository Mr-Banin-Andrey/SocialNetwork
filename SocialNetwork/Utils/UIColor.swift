//
//  UIColor.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.1.24..
//

import UIKit

extension UIColor {
    
    // MARK: - Main
    
    class var textColor: UIColor {
        UIColor(named: "textColor") ?? .black
    }
    
    class var mainBackgroundColor: UIColor {
        UIColor(named: "mainBackgroundColor") ?? .white
    }
}
