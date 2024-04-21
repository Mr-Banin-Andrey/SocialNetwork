//
//  DataConverter.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import Foundation

final class DataConverter {
        
    func convert(_ userCodable: UserCodable, _ postsCodable: [PostCodable]) throws -> User {
        let posts = postsCodable.map { convert($0) }
        let user = User(id: userCodable.id ?? "",
                        nickname: userCodable.nickname,
                        firstName: userCodable.firstName,
                        lastName: userCodable.lastName,
                        profession: userCodable.profession,
                        following: userCodable.following,
                        followers: userCodable.followers,
                        posts: posts,
                        photos: userCodable.photos,
                        savedPosts: postsCodable.map { convert($0) })
        
        return user
    }
    
    func convert(_ userCodable: UserCodable, _ posts: [Post]) throws -> User {
        let user = User(id: userCodable.id ?? "",
                        nickname: userCodable.nickname,
                        firstName: userCodable.firstName,
                        lastName: userCodable.lastName,
                        profession: userCodable.profession,
                        following: userCodable.following,
                        followers: userCodable.followers,
                        posts: posts,
                        photos: userCodable.photos,
                        savedPosts: [])
        
        return user
    }
    
    func convert(_ postCodable: PostCodable) -> Post {
        return Post(id: postCodable.id ?? "",
                    nickname: postCodable.nickname,
                    firstName: postCodable.firstName,
                    lastName: postCodable.lastName,
                    profession: postCodable.profession,
                    dateCreated: postCodable.dateCreated.dateValue(),
                    userCreatedID: postCodable.userCreatedID,
                    text: postCodable.text,
                    likes: postCodable.likes,
                    comments: postCodable.comments,
                    savedPost: postCodable.savedPost)
    }
}
