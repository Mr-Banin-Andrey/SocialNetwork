//
//  CloudStorageService.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 20.4.24..
//

import Foundation
import FirebaseStorage

protocol CloudStorageServiceProtocol {
    func downloadFile(basePath: CloudStorageService.Constants, pathString: String) async throws -> Data
    func uploadFile(imageData: Data, basePath: CloudStorageService.Constants, pathString: String) async throws
    func deleteFile(basePath: CloudStorageService.Constants, pathString: String) async throws
}

final class CloudStorageService {
    
    private let storage = Storage.storage()
    private let jsonDecoder = JSONDecoder()
    
    enum Constants: String {
        case userAvatars
        case userGallery
    }
}

extension CloudStorageService: CloudStorageServiceProtocol {
    
    func downloadFile(basePath: Constants, pathString: String) async throws -> Data {
        try await storage.reference(withPath: "\(basePath)/\(pathString)").data(maxSize: 1 * 1024 * 1024)
    }
    
    
    func uploadFile(imageData: Data, basePath: Constants, pathString: String) async throws {

        let storageReference = storage.reference(withPath: "\(basePath)/\(pathString)")

        do {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            _ = try await storageReference.putDataAsync(imageData, metadata: metadata)
        } catch {
            throw CloudStorageServiceError.imageDidNotUpdate
        }
    }
    
    func deleteFile(basePath: Constants, pathString: String) async throws {
        let storageReference = storage.reference(withPath: "\(basePath)/\(pathString)")
        do {
            try await storageReference.delete()
        } catch {
            print(">>>>> ", error)
            throw CloudStorageServiceError.failedToRemoveFile
        }
    }
    
}

enum CloudStorageServiceError: Error {
    case unexpectedEmptyMetadata
    case imageDidNotUpdate
    case failedToRemoveFile
}
