//
//  SettingsSheetViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 12.4.24..
//

import Foundation

// MARK: - SettingsSheetViewModelProtocol

protocol SettingsSheetViewModelProtocol: ViewModelProtocol where State == SettingsSheetState, ViewInput == SettingsSheetViewInput {}

// MARK: - Associated enums

enum SettingsSheetState {
    case initial
}

enum SettingsSheetViewInput {
    
}

// MARK: - SettingsSheetViewModel

final class SettingsSheetViewModel: SettingsSheetViewModelProtocol {
    
    // MARK: State related properties
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {

    }
    
}
