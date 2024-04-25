//
//  CommentCodable.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 22.4.24..
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CommentCodable: Codable {
    
    @DocumentID var id: String?
    let nickname: String
    let dateCreated: Timestamp
    let userCreatedID: String
    let postID: String
    let text: String
    let likes: [String]

    enum CodingKeys: CodingKey {
        case id
        case nickname
        case dateCreated
        case userCreatedID
        case postID
        case text
        case likes
    }
}
