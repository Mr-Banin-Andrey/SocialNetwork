//
//  UserTabBar.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 17.3.24..
//

import UIKit

final class UserTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    func setupTabBar() {
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .mainBackgroundColor
        
        
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.interRegular400Font.withSize(12),
            NSAttributedString.Key.foregroundColor: UIColor.notSelectIconColor
        ]
        
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.interRegular400Font.withSize(12),
            NSAttributedString.Key.foregroundColor: UIColor.selectedIconColor
        ]
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        tabBar.tintColor = .selectedIconColor
        tabBar.unselectedItemTintColor = .notSelectIconColor
    }
    
}
