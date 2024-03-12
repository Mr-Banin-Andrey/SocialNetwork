//
//  Coordinatable.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 12.3.24..
//

import UIKit

protocol Coordinatable: UIViewController {
    associatedtype CoordinatorType: Coordinator
    var coordinator: CoordinatorType? { get set }
}
