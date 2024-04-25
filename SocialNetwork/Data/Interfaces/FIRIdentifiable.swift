//
//  FIRIdentifiable.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 25.4.24..
//

import Foundation

protocol FIRIdentifiable {
    var id: String? { get }
    mutating func identify(_ newID: String)
}
