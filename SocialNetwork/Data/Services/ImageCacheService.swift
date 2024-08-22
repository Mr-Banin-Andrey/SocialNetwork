//
//  ImageCacheService.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import Foundation

protocol ImageCacheServiceProtocol {
    func add(imageData: Data, imageID: String) throws
    func getImageFromCache(imageID: String) -> Data?
}

final class ImageCacheService {
    
    private let imagesCache = NSCache<NSString, NSData>()
    
}

extension ImageCacheService: ImageCacheServiceProtocol {
    
    func add(imageData: Data, imageID: String) throws {
        
        imagesCache.setObject(imageData as NSData, forKey: imageID as NSString)
        
        guard let _ = imagesCache.object(forKey: imageID as NSString) else {
            throw ImageRepositoryError.unsuccessfulAdditionToCache
        }
    }
    
    func getImageFromCache(imageID: String) -> Data? {
        if let imageData = imagesCache.object(forKey: imageID as NSString) {
            return imageData as Data
        } else {
            return nil
        }
    }
    
    enum ImageRepositoryError: Error {
        case unsuccessfulAdditionToCache
    }
}
