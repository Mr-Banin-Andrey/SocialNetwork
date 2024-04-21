//
//  AuthenticationService.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.4.24..
//

import Foundation
import FirebaseAuth

final class AuthenticationService {
    
    private var verificationID = ""
    
    func registrationSendingCodeToPhone(phone: String, completion: @escaping (Result<Void, AuthenticationError>) -> Void) {
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in
              if let error = error {
                  completion(.failure(.failedSendCode))
                  return
              }
              
              guard let verificationID = verificationID else { return }
              self.verificationID = verificationID
              completion(.success(Void()))
          }
    }
    
    func registrationLogInToAccount(code: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: code
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(.failure(.failedToRegistration))
            }
            
            guard let authUser = authResult else {
                completion(.failure(.failedToRegistration))
                return
            }
            
            let id = authUser.user.uid
            completion(.success(id))
        }
    }
    
    
    enum AuthenticationError: Error {
        case failedToRegistration
        case failedSendCode
    }
}
