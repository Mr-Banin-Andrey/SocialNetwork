//
//  FirestoreService.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.4.24..
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirestoreService {
    
    enum Collections: String {
        case users
        case posts
        case comments
        case album
    }
    
    enum UserFields: String {
        case id
        case userCreatedID
    }
    
    enum FieldsForUpdate: String {
        case posts
        case likes
        case savedPosts
        case followers
        case following
    }
    
    enum FirestoreServiceError: Error {
        case notFoundUser
        case errorСreatingProfile
        case failedToCreateComment
        case failedToCreateLike
        case failedToUpdateSavedPosts
        case failedToSubscribe
        case failedToUpdatePersonalData
        case failedToCreatePost
    }
    
    // MARK: Private properties
    
    private let dataBase = Firestore.firestore()
    
    private var rootCollectionReference: CollectionReference!
    private var documentReference: DocumentReference!
    
    
    // MARK: User related methods
    
    func fetchObject<T:Codable>(id: String, model: T.Type, collections: Collections) async throws -> T {
        rootCollectionReference = dataBase.collection(collections.rawValue)
        documentReference = rootCollectionReference.document(id)
        let objectCodable = try await documentReference.getDocument(as: T.self)
        return objectCodable
    }
    
    //MARK: Posts related methods
    
    func fetchObjects<T:Codable>(givenBy id: String = "", model: T.Type, collection: Collections, field: UserFields? = .none) async throws -> [T] {
        rootCollectionReference = dataBase.collection(collection.rawValue)
        var querySnapshot: QuerySnapshot
        
        if let field {
            querySnapshot = try await rootCollectionReference.whereField(field.rawValue, isEqualTo: id).getDocuments()
        } else {
            querySnapshot = try await rootCollectionReference.getDocuments()
        }
        
        var objects: [T] = []
        for document in querySnapshot.documents {
            let object = try document.data(as: T.self)
            objects.append(object)
        }
        return objects
    }
    
    func createObjectDocument<T:Codable>(id: String, _ model: T, collection: Collections) async throws  {
        try dataBase.collection(collection.rawValue).document(id).setData(from: model)
    }
    
    func updateObject(id: String, collection: Collections, field: FieldsForUpdate, objectsArray: [String]) async throws {
        let reference = dataBase.collection(collection.rawValue).document(id)
        try await reference.updateData([field.rawValue: objectsArray])
    }
    
    func updatePersonalData(user: User) async throws  {
        let reference = dataBase.collection(Collections.users.rawValue).document(user.id)
        try await reference.updateData(["lastName": user.lastName,
                                        "firstName": user.firstName,
                                        "nickname": user.nickname,
                                        "profession": user.profession
                                       ])
    }
}
