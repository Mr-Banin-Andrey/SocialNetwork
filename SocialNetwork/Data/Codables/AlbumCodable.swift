//
//  AlbumCodable.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 24.4.24..
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AlbumCodable: Codable {
    
    @DocumentID var id: String?
    let photos: [String]
    
    enum CodingKeys: CodingKey {
        case id
        case photos
    }
}
