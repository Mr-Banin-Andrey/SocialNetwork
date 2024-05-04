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
    
    func checkIfUserNotExists(email: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {

        auth.fetchSignInMethods(forEmail: email) { signInMethods, error in
            if let error {
                print(error)
                completion(.failure(.failedToCheckIfEmailIsRegistered))
            }
            
            if let signInMethods {
                completion(.failure(.emailAlreadyExists))
            } else {
                completion(.success(email))
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
    }
    
    // MARK: Types
    
    enum AuthenticationError: Error {
        case loginNotRegistered(errorMessage: String)
        case authResultIsNil
        case failedToCreateUser
        case failedToSignIn
        case failedToSignUp
        case failedToCheckIfEmailIsRegistered
        case emailAlreadyExists
    }
}
