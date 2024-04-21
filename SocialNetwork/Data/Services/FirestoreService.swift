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
    }
    
    enum Fields: String {
        case id
        case userCreatedID
    }
    
    // MARK: Private properties
    
    private let dataBase = Firestore.firestore()
    
    private var rootCollectionReference: CollectionReference!
    private var documentReference: DocumentReference!
    
    
    // MARK: User related methods
    
    func fetchUserData<T:Codable>(id: String, model: T.Type, collections: Collections) async throws -> T {
        rootCollectionReference = dataBase.collection(collections.rawValue)
        documentReference = rootCollectionReference.document(id)
        let objectCodable = try await documentReference.getDocument(as: T.self)
        return objectCodable
    }
    
    //MARK: Posts related methods
        
    func fetchObjects<T:Codable>(givenBy id: String = "", model: T.Type, collection: Collections, field: Fields? = .none) async throws -> [T] {
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
}
