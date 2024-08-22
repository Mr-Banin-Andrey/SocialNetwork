//
//  PostCodable.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.4.24..
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct PostCodable: Codable {
    
    @DocumentID var id: String?
    let nickname: String
    let firstName: String
    let lastName: String
    let profession: String
    
    let dateCreated: Timestamp
    let userCreatedID: String
    
    let text: String
    let likes: [String]
    let comments: [String]

    
    enum CodingKeys: CodingKey {
        case id
        case nickname
        case firstName
        case lastName
        case profession
        case dateCreated
        case userCreatedID
        case text
        case likes
        case comments
    }
}
