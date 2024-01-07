//
//  Factory.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.1.24..
//

import UIKit

final class Factory {
    
    enum Flow {
        case main
        case profile
        case saved
    }
    
    private let flow: Flow
    private let navController = UINavigationController()
    
    //MARK: Initial
    
    init(flow: Flow) {
        self.flow = flow
        startModule()
    }
    
    //MARK: Private methods
    
    private func startModule() {
        switch flow {
        case .main:
            print("main")
            // вью модель + координатор
            // вью контроллер
            // tabbar
        case .profile:
            print("profile")
        case .saved:
            print("saved")
        }
    }
}
