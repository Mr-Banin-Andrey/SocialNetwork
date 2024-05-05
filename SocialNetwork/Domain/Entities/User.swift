//
//  User.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import Foundation

struct User {
    
    let id: String
    var nickname: String
    var firstName: String
    var lastName: String
    var profession: String
    var following: [String]
    var followers: [String]
    var posts: [Post]
    var photos: [AlbumCodable]
    var savedPosts: [Post]
}
