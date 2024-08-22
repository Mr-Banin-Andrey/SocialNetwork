//
//  GroupingForPosts.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import Foundation

final class GroupingForPosts {
    
    class func groupByDate(_ posts: [Post]) -> [(date: Date, posts: [Post])] {
        var groupedPosts: [(date: Date, posts: [Post])] = []
        
        for post in posts {
            let dateCreated = post.dateCreated
            
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: dateCreated)
            guard let targetDate = Calendar.current.date(from: dateComponents) else { continue }
            if let groupIndex = groupedPosts.firstIndex(where: { $0.date == targetDate }) {
                groupedPosts[groupIndex].posts.append(post)
            } else {
                groupedPosts.append((targetDate, [post]))
            }
        }
        
        groupedPosts.sort(by: { $0.date > $1.date } )
        
        for (index, _) in groupedPosts.enumerated() {
            groupedPosts[index].posts.sort(by: { $0.dateCreated > $1.dateCreated })
        }
        
        return groupedPosts
    }
}
