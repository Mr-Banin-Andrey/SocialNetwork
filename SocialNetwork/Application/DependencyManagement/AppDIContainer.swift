//
//  AppDIContainer.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 29.3.24..
//

import Foundation

struct AppDIContainer {
    private static var assemblers: [String: () -> Any] = [:]
    private static var cache: [String: Any] = [:]
}

extension AppDIContainer {
    static func register<T>(type: T.Type, _ assembler: @autoclosure @escaping () -> T) {
        assemblers[String(describing: type.self)] = assembler
    }
    
    static func resolve<T>(_ type: T.Type) -> T? {
        return assemblers[String(describing: type.self)]?() as? T
    }
}
