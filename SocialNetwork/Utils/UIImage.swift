//
//  UIImage.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.1.24..
//

import UIKit

extension UIImage {
    
    // MARK: - Authentication
    
    class var logInLogoImage: UIImage {
        UIImage(named: "logInLogo") ?? UIImage()
    }
    
    class var confirmationCheckMarkImage: UIImage {
        UIImage(named: "confirmationCheckMark") ?? UIImage()
    }
    
    class var arrowLeftImage: UIImage {
        UIImage(systemName: "arrow.left") ?? UIImage()
    }
    
    // MARK: - ImageSheet
    
    class var cameraImage: UIImage {
        UIImage(systemName: "camera") ?? UIImage()
    }
    
    class var galleryImage: UIImage {
        UIImage(systemName: "photo.on.rectangle") ?? UIImage()
    }
    
    // MARK: - Comment
    
    class var paperclipImage: UIImage {
        UIImage(systemName: "paperclip") ?? UIImage()
    }
    
    // MARK: - EditPersonalData
    
    class var checkmarkImage: UIImage {
        UIImage(systemName: "checkmark") ?? UIImage()
    }
    
    // MARK: - PhotoGallery
    
    class var plusImage: UIImage {
        UIImage(systemName: "plus") ?? UIImage()
    }
    
    // MARK: - Post
    
    class var verticalEllipseImage: UIImage {
        UIImage(named: "verticalEllipse") ?? UIImage()
    }
    
    class var likeImage: UIImage {
        UIImage(systemName: "heart") ?? UIImage()
    }
    
    class var likeFillImage: UIImage {
        UIImage(systemName: "heart.fill") ?? UIImage()
    }
    
    class var commentImage: UIImage {
        UIImage(systemName: "message") ?? UIImage()
    }
    
    class var bookmarkImage: UIImage {
        UIImage(systemName: "bookmark") ?? UIImage()
    }
    
    class var bookmarkFillImage: UIImage {
        UIImage(systemName: "bookmark.fill") ?? UIImage()
    }
    
    // MARK: - ProfileView
    
    class var exitImage: UIImage {
        UIImage(systemName: "door.left.hand.open") ?? UIImage()
    }
    
    //MARK: - ProfileHeader
    
    class var chevronRightImage: UIImage {
        UIImage(systemName: "chevron.right") ?? UIImage()
    }
    
    class var squareAndPencilImage: UIImage {
        UIImage(systemName: "square.and.pencil") ?? UIImage()
    }
    
    // MARK: - TabBar
    
    class var vectorHouseNotSelectImage: UIImage {
        UIImage(named: "vectorHouseBlack") ?? UIImage()
    }
    
    class var vectorHouseSelectedImage: UIImage {
        UIImage(named: "vectorHouseOrange") ?? UIImage()
    }
    
    class var profileIconSelectedImage: UIImage {
        UIImage(named: "profileIconSelected") ?? UIImage()
    }
    
    class var profileIconNotSelectImage: UIImage {
        UIImage(named: "profileIconNotSelect") ?? UIImage()
    }
    
    class var savedIconImage: UIImage {
        UIImage(named: "savedIcon") ?? UIImage()
    }
    
    
    //MARK: - MockObject
    
    class var forPostMockObjectImage: UIImage {
        UIImage(named: "forPost") ?? UIImage()
    }

    class var forGalleryCellMockObjectImage: UIImage {
        UIImage(named: "forGallery") ?? UIImage()
    }
}
