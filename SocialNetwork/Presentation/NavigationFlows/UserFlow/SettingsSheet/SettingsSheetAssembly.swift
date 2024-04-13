//
//  SettingsSheetAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 12.4.24..
//

import Foundation

final class SettingsSheetAssembly {
    
    func viewController() -> SettingsSheetViewController {
        let viewModel = SettingsSheetViewModel()
        let viewController = SettingsSheetViewController(viewModel: viewModel)
        return viewController
    }
}
