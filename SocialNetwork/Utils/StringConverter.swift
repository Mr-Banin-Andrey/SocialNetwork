//
//  StringConverter.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.4.24..
//

import UIKit

final class StringConverter {
    
    class func editColor(name: String, count: Int) ->  NSMutableAttributedString {
        let text = "\(name)  \(count)"
        let underlineAttributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "\(count)")
        underlineAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.textSecondaryColor, range: range)
        return underlineAttributedString
    }
    
}
