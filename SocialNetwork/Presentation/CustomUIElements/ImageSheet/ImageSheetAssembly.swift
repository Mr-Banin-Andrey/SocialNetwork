//
//  ImageSheetAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.5.24..
//

import Foundation

final class ImageSheetAssembly {
    
    private var objectID: String
    private var objectType: ImageSheetViewModel.ObjectType
    
    var viewController: ImageSheetViewController {
        let viewModel = ImageSheetViewModel(objectID: objectID, objectType: objectType)
        let viewController = ImageSheetViewController(viewModel: viewModel)
        return viewController
    }
    
    init(objectID: String, objectType: ImageSheetViewModel.ObjectType) {
        self.objectID = objectID
        self.objectType = objectType
    }
}
