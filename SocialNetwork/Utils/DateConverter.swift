//
//  DateConverter.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import Foundation

final class DateConverter {
    private static let dateFormatter = DateFormatter()
    
    class func dateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru-RU")
        return dateFormatter.string(from: date)
    }
}
