//
//  UserUseCase.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.4.24..
//

import Foundation

final class UserUseCase {
    
    // MARK: Private properties
    
    private lazy var firestoreService = FirestoreService()
    private lazy var dataConverter = DataConverter()
    private lazy var cloudStorageService = CloudStorageService()
    private lazy var imageCacheService = ImageCacheService()
    
    // MARK: Methods
    
    func fetchUser(userID: String, posts: [Post] = [], completionHandler: @escaping (User) -> Void = { _ in }) {
        Task {
            do {
                let userCodable = try await firestoreService.fetchUserData(id: userID, model: UserCodable.self, collections: .users)
                
                if posts.isEmpty {
                    let postCodable = try await firestoreService.fetchObjects(givenBy: userID, model: PostCodable.self, collection: .posts, field: .userCreatedID)
                    let user = try dataConverter.convert(userCodable, postCodable)
                    completionHandler(user)
                    
                } else {
                    let user = try dataConverter.convert(userCodable, posts)
                    completionHandler(user)
                }
                
            } catch {
                print("error: fetchUser")
            }
        }
    }
    
    func fetchPosts(following: [String], completionHandler: @escaping ([Post], [Post]) -> Void = { _,_ in }) {
        Task {
            do {
                let allPosts = try await firestoreService.fetchObjects(model: PostCodable.self, collection: .posts).map { dataConverter.convert($0)}
                var postsForUser: [Post] = []
                for id in following {
                    let posts = try await firestoreService.fetchObjects(givenBy: id, model: PostCodable.self, collection: .posts, field: .userCreatedID).map { dataConverter.convert($0)}
                    postsForUser += posts
                }
                
                completionHandler(allPosts, postsForUser)
            } catch {
                print("error: fetchPosts")
            }
        }
    }
    
    func fetchImageData(imageID: String, basePath: CloudStorageService.Constants, completion: @escaping (Result<Data, Error>) -> Void = { _ in }) {
        if let imageData = imageCacheService.getImageFromCache(idImage: imageID) {
            completion(.success(imageData))
        } else {
            Task {
                do {
                    let imageData = try await cloudStorageService.downloadFile(basePath: basePath, pathString: imageID)
                    try imageCacheService.add(imageData: imageData, idImage: imageID)
                    
                    completion(.success(imageData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
