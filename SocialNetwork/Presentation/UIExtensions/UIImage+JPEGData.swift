//
//  UIImage+JPEGData.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 21.4.24..
//

import UIKit

extension UIImage {
    
    enum CompressionError: Error {
        case failedToCompressToDataOfGivenSize
    }

    func jpegData(ofSizeLessThenOrEqualTo maxSize: CGFloat) throws -> Data? {
        var shouldContinue: Bool = true
        let maxSizeInBytes = maxSize * 1024 * 1024
        var compressionQuality: CGFloat = 0.9
        repeat {
            guard let jpegData = self.jpegData(compressionQuality: compressionQuality) else {
                return nil
            }
            if (CGFloat(jpegData.count) < maxSizeInBytes)  {
                return jpegData
            }
            compressionQuality -= 0.1
            shouldContinue = compressionQuality > 0.1
        } while shouldContinue
        throw CompressionError.failedToCompressToDataOfGivenSize
    }
}
