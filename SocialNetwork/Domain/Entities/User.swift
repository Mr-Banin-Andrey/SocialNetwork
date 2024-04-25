//
//  User.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import Foundation

struct User {
    
    let id: String
    let nickname: String
    let firstName: String
    let lastName: String
    let profession: String
    let following: [String]
    let followers: [String]
    let posts: [Post]
    let photos: [AlbumCodable]
    let savedPosts: [Post]
}
