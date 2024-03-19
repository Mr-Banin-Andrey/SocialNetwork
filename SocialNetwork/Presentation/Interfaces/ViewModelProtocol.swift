//
//  ViewModelProtocol.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.1.24..
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    associatedtype State
    associatedtype ViewInput
    
    var state: State { get }
    var onStateDidChange: ((State) -> Void)? { get set }
    func updateState(with viewInput: ViewInput)
}
