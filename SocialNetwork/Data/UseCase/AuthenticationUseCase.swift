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
    
    func singUp(
        email: String,
        password:String,
        user: User,
        completion: @escaping (Result<User, AuthenticationService.AuthenticationError>) -> Void
    ) {
        authenticationService.signUp(email: email, password: password) { [weak self] (result: Result<String,AuthenticationService.AuthenticationError>) in
            switch result {
            case .success(let userID):
                self?.addNewUser(userID: userID, user: user) { (result:Result<User,FirestoreService.FirestoreServiceError>) in
                    switch result {
                    case .success(let user):
                        completion(.success(user))
                    case .failure(let failure):
                        completion(.failure(.failedToCreateUser))
                    }
                }
            case .failure(let error):
                print("failedToCreateUser \(error)")
            }
        }
    }
    
    func fetchUser(userID: String, completion: @escaping (Result<User, FirestoreService.FirestoreServiceError>) -> Void ) {
        Task {
            do {
                let userCodable = try await firestoreService.fetchObject(id: userID, model: UserCodable.self, collections: .users)
                let allComments = try await firestoreService.fetchObjects(model: CommentCodable.self, collection: .comments)
                let posts = try await firestoreService.fetchObjects(givenBy: userID, model: PostCodable.self, collection: .posts, field: .userCreatedID).map { dataConverter.convert($0, allComments)}
                
                var savedPosts: [PostCodable] = []
                for postID in userCodable.savedPosts {
                    let post = try await firestoreService.fetchObject(id: postID, model: PostCodable.self, collections: .posts)
                    savedPosts.append(post)
                }
                
                var photos: [AlbumCodable] = []
                for albumID in userCodable.photos {
                    let album = try await firestoreService.fetchObject(id: albumID, model: AlbumCodable.self, collections: .album)
                    photos.append(album)
                }
                
                let user = try dataConverter.convert(userCodable, posts, savedPosts.map { dataConverter.convert($0, allComments) }, photos: photos )
                completion(.success(user))
            } catch {
                print("error: fetchUser")
                completion(.failure(.notFoundUser))
            }
        }
    }
    
    func addNewUser(
        userID: String,
        user: User,
        completion: @escaping (Result<User, FirestoreService.FirestoreServiceError>) -> Void ) {
        Task {
            do {
                let newUserCodable = UserCodable(
                    id: userID,
                    nickname: user.nickname,
                    firstName: user.firstName,
                    lastName: user.lastName,
                    profession: "",
                    following: [],
                    followers: [],
                    posts: [],
                    photos: [],
                    savedPosts: [])
                try await firestoreService.createObjectDocument(userID: userID, newUserCodable, collection: .users)
                let user = try dataConverter.convert(newUserCodable)
                completion(.success(user))
            } catch {
                completion(.failure(.errorСreatingProfile))
            }
        }
    }
    
}
