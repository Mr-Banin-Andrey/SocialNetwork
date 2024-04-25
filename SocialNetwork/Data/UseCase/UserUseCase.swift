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
                let userCodable = try await firestoreService.fetchObject(id: userID, model: UserCodable.self, collections: .users)
                
                if posts.isEmpty {
                    let allComments = try await firestoreService.fetchObjects(model: CommentCodable.self, collection: .comments)
                    let postsCodable = try await firestoreService.fetchObjects(givenBy: userID, model: PostCodable.self, collection: .posts, field: .userCreatedID).map { dataConverter.convert($0, allComments)}
                    
                    var photos: [AlbumCodable] = []
                    for albumID in userCodable.photos {
                        let album = try await firestoreService.fetchObject(id: albumID, model: AlbumCodable.self, collections: .album)
                        photos.append(album)
                    }
                    
                    let user = try dataConverter.convert(userCodable, postsCodable, photos: photos)
                    completionHandler(user)
                    
                } else {
                    
                    var photos: [AlbumCodable] = []
                    for albumID in userCodable.photos {
                        let album = try await firestoreService.fetchObject(id: albumID, model: AlbumCodable.self, collections: .album)
                        photos.append(album)
                    }
                    
                    let user = try dataConverter.convert(userCodable, posts, photos: photos)
                    completionHandler(user)
                }
                
            } catch {
                print("error: fetchUser")
            }
        }
    }
    
    func fetchPosts(completionHandler: @escaping ([Post]) -> Void = { _ in }) {
        Task {
            do {
                let allComments = try await firestoreService.fetchObjects(model: CommentCodable.self, collection: .comments)
                let allPosts = try await firestoreService.fetchObjects(model: PostCodable.self, collection: .posts).map { dataConverter.convert($0, allComments)}
            
                completionHandler(allPosts)
            } catch {
                print("error: fetchPosts")
            }
        }
    }
    
    func fetchImageData(imageID: String, basePath: CloudStorageService.Constants, completion: @escaping (Result<Data, Error>) -> Void = { _ in }) {
        if let imageData = imageCacheService.getImageFromCache(imageID: imageID) {
            completion(.success(imageData))
        } else {
            Task {
                do {
                    let imageData = try await cloudStorageService.downloadFile(basePath: basePath, pathString: imageID)
                    try imageCacheService.add(imageData: imageData, imageID: imageID)
                    
                    completion(.success(imageData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func addImageInCache(image: Data, imageID: String) {
        Task {
            do {
                try imageCacheService.add(imageData: image, imageID: imageID)
            } catch {
                print(">>>... error add in cache")
            }
        }
    }
}
