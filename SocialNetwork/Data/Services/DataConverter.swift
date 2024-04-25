//
//  DataConverter.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import Foundation

final class DataConverter {
        
    func convert(_ userCodable: UserCodable, _ postsCodable: [PostCodable], _ comments: [CommentCodable], photos: [AlbumCodable]) throws -> User {
        let user = User(id: userCodable.id ?? "",
                        nickname: userCodable.nickname,
                        firstName: userCodable.firstName,
                        lastName: userCodable.lastName,
                        profession: userCodable.profession,
                        following: userCodable.following,
                        followers: userCodable.followers,
                        posts: postsCodable.map { convert($0, comments) },
                        photos: photos,
                        savedPosts: postsCodable.map { convert($0, comments) })
        return user
    }
    
    func convert(_ userCodable: UserCodable, _ posts: [Post] = [], _ savedPosts: [Post] = [], photos: [AlbumCodable] = []) throws -> User {
        let user = User(id: userCodable.id ?? "",
                        nickname: userCodable.nickname,
                        firstName: userCodable.firstName,
                        lastName: userCodable.lastName,
                        profession: userCodable.profession,
                        following: userCodable.following,
                        followers: userCodable.followers,
                        posts: posts,
                        photos: photos,
                        savedPosts: savedPosts)
        return user
    }
    
    func convert(_ postCodable: PostCodable, _ allComments: [CommentCodable])  -> Post {
        
        let comments = allComments.filter { $0.postID == postCodable.id }
        
        return Post(id: postCodable.id ?? "",
                    nickname: postCodable.nickname,
                    firstName: postCodable.firstName,
                    lastName: postCodable.lastName,
                    profession: postCodable.profession,
                    dateCreated: postCodable.dateCreated.dateValue(),
                    userCreatedID: postCodable.userCreatedID,
                    text: postCodable.text,
                    likes: postCodable.likes,
                    comments: comments,
                    savedPost: postCodable.savedPost)
    }
}
