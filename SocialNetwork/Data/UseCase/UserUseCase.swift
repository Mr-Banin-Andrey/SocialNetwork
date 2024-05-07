//
//  UserUseCase.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.4.24..
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserUseCase {
    
    // MARK: Private properties
    
    var user: User
    
    private lazy var authenticationService = AuthenticationService()
    private lazy var firestoreService = FirestoreService()
    private lazy var dataConverter = DataConverter()
    private lazy var cloudStorageService = CloudStorageService()
    private lazy var imageCacheService = ImageCacheService()
    
    //MARK: Initial
    
    init(user: User) {
        self.user = user
    }
    
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
            
                completionHandler(allPosts.map { dataConverter.convertForUser($0, user) })
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
    
    func signOut() {
        authenticationService.signOut()
    }
    
    // MARK: Update Data Methods
    
    func addCommentInPost(post: Post, comment: String, completion: @escaping (Result<CommentCodable, FirestoreService.FirestoreServiceError>) -> Void = { _ in }) {
        
        let date = Date()
        
        let commentCodable = CommentCodable(
            id: UUID().uuidString,
            nickname: user.nickname,
            dateCreated: Timestamp(date: date),
            userCreatedID: user.id,
            postID: post.id,
            text: comment,
            likes: []
        )
        
        Task {
            do {
                try await firestoreService.createObjectDocument(id: commentCodable.id ?? "", commentCodable, collection: .comments)
                var comments: [String] = post.comments.map { $0.postID }
                comments.append(commentCodable.postID)
                try await firestoreService.updateObject(id: post.id, collection: .posts, field: .posts, objectsArray: comments)
                DispatchQueue.main.async {
                    completion(.success(commentCodable))
                }
            } catch (let error) {
                print("Error update comments: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.failedToCreateComment))
                }
            }
        }
    }
    
    func addLikePost(post: Post, completion: @escaping (Result<[String], FirestoreService.FirestoreServiceError>) -> Void = { _ in }) {
        
        Task {
            do {
                if post.likePost {
                    var likes: [String] = post.likes.map { $0 }
                    likes.removeAll { $0 == user.id }
                    try await firestoreService.updateObject(id: post.id, collection: .posts, field: .likes, objectsArray: likes)
                    DispatchQueue.main.async {
                        completion(.success(likes))
                    }
                } else {
                    var likes: [String] = post.likes.map { $0 }
                    likes.append(user.id)
                    try await firestoreService.updateObject(id: post.id, collection: .posts, field: .likes, objectsArray: likes)
                    DispatchQueue.main.async {
                        completion(.success(likes))
                    }
                }
            } catch (let error) {
                print("Error update likes: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.failedToCreateLike))
                }
            }
        }
    }
    
    func updateStateSubscriber(userCreatedID: String) -> Bool {
        var subscriber = user.following.filter { $0 == userCreatedID }.isEmpty
        subscriber.toggle()
        return subscriber
    }
    
    func addBookmark(post: Post, completion: @escaping (Result<Void, FirestoreService.FirestoreServiceError>) -> Void = { _ in }) {
        
        Task {
            do {
                if post.savedPost {
                    var post = post
                    post.savedPost = false
                    var savedPosts: [String] = user.savedPosts.map { $0.id }
                    savedPosts.removeAll { $0 == post.id }
                    user.savedPosts.removeAll { $0.id == post.id }
                    
                    try await firestoreService.updateObject(id: user.id, collection: .users, field: .savedPosts, objectsArray: savedPosts)
                    DispatchQueue.main.async {
                        completion(.success(Void()))
                    }
                } else {
                    var post = post
                    post.savedPost = true
                    user.savedPosts.append(post)
                    var savedPosts: [String] = user.savedPosts.map { $0.id }
                    try await firestoreService.updateObject(id: user.id, collection: .users, field: .savedPosts, objectsArray: savedPosts)
                    DispatchQueue.main.async {
                        completion(.success(Void()))
                    }
                }
            } catch (let error) {
                print("Error update likes: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.failedToUpdateSavedPosts))
                }
            }
        }
    }
    
    func toSubscribe(subscriberID: String, completion: @escaping (Result<Void, FirestoreService.FirestoreServiceError>) -> Void = { _ in }) {
        Task {
            do {
                var isSubscriber = user.following.filter { $0 == subscriberID }.isEmpty
                isSubscriber.toggle()
                
                if isSubscriber {
                    
                    let subscriber = try await firestoreService.fetchObject(id: subscriberID, model: UserCodable.self, collections: .users)
                    var followers = subscriber.followers
                    followers.removeAll { $0 == user.id }
                    try await firestoreService.updateObject(id: subscriber.id ?? "", collection: .users, field: .followers, objectsArray: followers)
                    
                    user.following.removeAll { $0 == subscriberID }
                    try await firestoreService.updateObject(id: user.id, collection: .users, field: .following, objectsArray: user.following)
                    DispatchQueue.main.async {
                        completion(.success(Void()))
                    }
                    
                } else {
                    let subscriber = try await firestoreService.fetchObject(id: subscriberID, model: UserCodable.self, collections: .users)
                    var followers = subscriber.followers
                    followers.append(user.id)
                    try await firestoreService.updateObject(id: subscriber.id ?? "", collection: .users, field: .followers, objectsArray: followers)
                    
                    user.following.append(subscriberID)
                    try await firestoreService.updateObject(id: user.id, collection: .users, field: .following, objectsArray: user.following)
                    DispatchQueue.main.async {
                        completion(.success(Void()))
                    }
                }
                
            } catch (let error) {
                print("Error toSubscribe: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.failedToSubscribe))
                }
            }
        }
    }
    
    func updateProfileData(imageData: Data, user: User, completion: @escaping (Result<Void, FirestoreService.FirestoreServiceError>) -> Void = { _ in }) {
        Task {
            do {
                
                if !user.lastName.isEmpty {
                    self.user.lastName = user.lastName
                }
                
                if !user.firstName.isEmpty {
                    self.user.firstName = user.firstName
                }
                
                if !user.nickname.isEmpty {
                    self.user.nickname = user.nickname
                }
                
                if !user.profession.isEmpty {
                    self.user.profession = user.profession
                }

                try await firestoreService.updatePersonalData(user: self.user)
                try await cloudStorageService.uploadFile(imageData: imageData, basePath: .userAvatars, pathString: user.id)
                try imageCacheService.add(imageData: imageData, imageID: user.id)
                
                DispatchQueue.main.async {
                    completion(.success(Void()))
                }
            } catch (let error){
                print("Error updateProfileData: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.failedToUpdatePersonalData))
                }
            }
        }
    }
    
    func createPost(newPost: Post, newPhoto: Data, completion: @escaping (Result<Void, FirestoreService.FirestoreServiceError>) -> Void = { _ in }) {
        Task {
            do {
                
                let postCodable = PostCodable(
                    id: newPost.id,
                    nickname: newPost.nickname,
                    firstName: newPost.firstName,
                    lastName: newPost.lastName,
                    profession: newPost.profession,
                    dateCreated: Timestamp(date: newPost.dateCreated),
                    userCreatedID: newPost.userCreatedID,
                    text: newPost.text,
                    likes: newPost.likes,
                    comments: [])
                
                user.posts.append(newPost)
                
                let posts = user.posts.map { $0.id }
                try await firestoreService.updateObject(id: user.id, collection: .users, field: .posts, objectsArray: posts)
                try await firestoreService.createObjectDocument(id: newPost.id, postCodable, collection: .posts)
                try await cloudStorageService.uploadFile(imageData: newPhoto, basePath: .userGallery, pathString: newPost.id)
                try imageCacheService.add(imageData: newPhoto, imageID: newPost.id)
                
                DispatchQueue.main.async {
                    completion(.success(Void()))
                }
                
            } catch (let error) {
                print("Error createPost: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.failedToCreatePost))
                }
            }
        }
    }
}
