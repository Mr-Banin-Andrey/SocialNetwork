//
//  AppFactory.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 12.3.24..
//

import UIKit

protocol AppFactoryProtocol: AnyObject {
    func makeFlowCoordinator(_ moduleType: NavigationFlowType, rootCoordinator: RootCoordinator) throws -> any Coordinator
}

final class AppFactory {
    
    private func makeAuthenticationCoordinator(rootCoordinator: RootCoordinator) throws -> any Coordinator {
        do {
            let authenticationCoordinator = try AuthenticationCoordinator(navigationController: rootCoordinator.navigationController)
            authenticationCoordinator.parentCoordinator = rootCoordinator
            return authenticationCoordinator
        } catch {
            throw AppFactoryError.failedToMakeFlow
        }
    }
    
    enum AppFactoryError: Error {
        case failedToMakeFlow
        case emptyUserProfile
    }
}

extension AppFactory: AppFactoryProtocol {
    func makeFlowCoordinator(_ moduleType: NavigationFlowType, rootCoordinator: RootCoordinator) throws -> any Coordinator {
        switch moduleType {
        case .authentication:
            return try makeAuthenticationCoordinator(rootCoordinator: rootCoordinator)
            
        case .main:
            return try makeAuthenticationCoordinator(rootCoordinator: rootCoordinator)
        }
    }
}
