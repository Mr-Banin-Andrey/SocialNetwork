//
//  AuthenticationService.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.4.24..
//

import Foundation
import FirebaseAuth

final class AuthenticationService {
    
    // MARK: Private propeties
    
    private let auth = Auth.auth()
    
    // MARK: Public methods
    
    func signIn(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        auth.signIn(withEmail: email, password: password) {  [weak self] authResult, error in
            guard let self else { return }
            
            if let error {
                print(error)
                completion(.failure(.failedToSignIn))
                return
            }
            
            guard let authUser = authResult?.user, let email = authUser.email else {
                completion(.failure(.authResultIsNil))
                return
            }
            
            let id = authUser.uid
            completion(.success(id))
        }
       
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self else { return }
            
            if let error {
                print(error)
                return
            }
            
            guard let authUser  = authResult?.user, let email = authUser.email else {
                completion(.failure(.authResultIsNil))
                return
            }
            
            let id = authUser.uid
            completion(.success(id))
        }
    }
    
    func sendPasswordReset(email: String, completion: @escaping (Result<Void, AuthenticationError>) -> Void) {

        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error sendPasswordReset: \(error.localizedDescription)")
                completion(.failure(.emailDoesNotExist))
            }
            
            completion(.success(Void()))
        }
    }
    
    func authUser(completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        if let currentUser = auth.currentUser {
            completion(.success(currentUser.uid))
        } else {
            completion(.failure(.userIsNotLoggedIn))
        }
    }
    
    
    func signOut() {
        try? auth.signOut()
        
    }
    
    // MARK: Types
    
    enum AuthenticationError: Error {
        case userIsNotLoggedIn
        case authResultIsNil
        case failedToCreateUser
        case failedToSignIn
        case failedToSignUp
        case failedLoadingProfile
        case emailDoesNotExist
    }
}
