//
//  Post.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import Foundation

struct Post {
    
    let id: String
    let nickname: String
    let firstName: String
    let lastName: String
    let profession: String
    let dateCreated: Date
    let userCreatedID: String
    let text: String
    var likes: [String]
    var comments: [CommentCodable]
    var savedPost: Bool
    var likePost: Bool
    
}
