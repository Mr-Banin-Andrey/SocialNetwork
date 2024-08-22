//
//  UserCodable.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.4.24..
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserCodable: Codable {
    
    @DocumentID var id: String?
    let nickname: String
    let firstName: String
    let lastName: String
    let profession: String
    
    let following: [String]
    let followers: [String]
    let posts: [String]
    let photos: [String]
    let savedPosts: [String]
    
    enum CodingKeys: CodingKey {
        case id
        case nickname
        case firstName
        case lastName
        case profession
        case following
        case followers
        case posts
        case photos
        case savedPosts
    }
}
