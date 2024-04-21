//
//  ImageCacheService.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import Foundation

protocol ImageCacheServiceProtocol {
    func add(imageData: Data, idImage: String) throws
    func getImageFromCache(idImage: String) -> Data?
}

final class ImageCacheService {
    
    private let imagesCache = NSCache<NSString, NSData>()
    
}

extension ImageCacheService: ImageCacheServiceProtocol {
    
    func add(imageData: Data, idImage: String) throws {
        
        imagesCache.setObject(imageData as NSData, forKey: idImage as NSString)
        
        guard let _ = imagesCache.object(forKey: idImage as NSString) else {
            throw ImageRepositoryError.unsuccessfulAdditionToCache
        }
    }
    
    func getImageFromCache(idImage: String) -> Data? {
        if let imageData = imagesCache.object(forKey: idImage as NSString) {
            return imageData as Data
        } else {
            return nil
        }
    }
    
    enum ImageRepositoryError: Error {
        case unsuccessfulAdditionToCache
    }
}
