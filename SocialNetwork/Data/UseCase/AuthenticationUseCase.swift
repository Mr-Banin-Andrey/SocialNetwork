//
//  AuthenticationUseCase.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 15.4.24..
//

import Foundation

final class AuthenticationUseCase {
    
    // MARK: Private properties
    
    private lazy var authenticationService = AuthenticationService()
    private lazy var firestoreService = FirestoreService()
    private lazy var dataConverter = DataConverter()
    
    
    // MARK: Methods

    func registrationSendingCodeToPhone(phone: String, completion: @escaping (Result<Void,AuthenticationService.AuthenticationError>) -> Void) {
        authenticationService.registrationSendingCodeToPhone(phone: phone) { (result: Result<Void,AuthenticationService.AuthenticationError>) in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func registrationLogInToAccount(code: String, completion: @escaping (Result<String,AuthenticationService.AuthenticationError>) -> Void) {
        authenticationService.registrationLogInToAccount(code: code) { (result: Result<String,AuthenticationService.AuthenticationError>) in
            switch result {
            case .success(let userID):
                completion(.success(userID))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchUser(userID: String, completionHandler: @escaping (User) -> Void = { _ in }) {
        Task {
            do {
                let userCodable = try await firestoreService.fetchUserData(id: userID, model: UserCodable.self, collections: .users)
                let postsCodable = try await firestoreService.fetchObjects(givenBy: userCodable.id ?? "", model: PostCodable.self, collection: .posts, field: .userCreatedID)
                let user = try dataConverter.convert(userCodable, postsCodable)
                
                completionHandler(user)
            } catch {
                print("error: fetchUser")
            }
        }
    }
    
}
