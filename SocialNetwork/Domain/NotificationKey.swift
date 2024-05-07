//
//  NotificationKey.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.5.24..
//

import Foundation

enum NotificationKey {
    static let wholePostKey = Notification.Name("wholePostKey")
    static let settingsSheetKey = Notification.Name("settingsSheetKey")
    static let editPersonalDataKey = Notification.Name("editPersonalDataKey")
    static let newAvatarKey = Notification.Name("newAvatarKey")
    static let newPostKey = Notification.Name("newPostKey")
}
