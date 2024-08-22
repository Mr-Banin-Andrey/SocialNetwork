//
//  DependencyWrapper.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 29.3.24..
//

import Foundation

@propertyWrapper
struct Dependency<T> {
    var dependency: T
    
    init() {
        guard let dependency = AppDIContainer.resolve(T.self) else {
            fatalError("Dependency \(T.self) was attemted to resolve but was never registered")
        }
        self.dependency = dependency
    }
    
    var wrappedValue: T {
        get { dependency }
        set { dependency = newValue }
    }
}
