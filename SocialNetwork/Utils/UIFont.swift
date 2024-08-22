//
//  UIFont.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.1.24..
//

import UIKit

extension UIFont {
    
    class var interRegular400Font: UIFont {
        UIFont(name: "Inter-Regular", size: 14) ?? .systemFont(ofSize: 5)
    }
    
    class var interMedium500Font: UIFont {
        UIFont(name: "Inter-Medium", size: 16) ?? .systemFont(ofSize: 5)
    }
    
    class var interSemiBold600Font: UIFont {
        UIFont(name: "Inter-SemiBold", size: 18) ?? .systemFont(ofSize: 5)
    }
    
    class var interBold700Font: UIFont {
        UIFont(name: "Inter-Bold", size: 18) ?? .systemFont(ofSize: 5)
    }
    
}
