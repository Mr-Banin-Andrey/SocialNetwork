//
//  Data+Image.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import UIKit.UIImage

extension Data {
    var image: UIImage? {
        return UIImage(data: self)
    }
}
