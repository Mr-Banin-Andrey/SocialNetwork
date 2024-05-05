//
//  DimmingViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.5.24..
//

import UIKit

protocol DimmingViewControllerProtocol: UIViewController {
    func present(on viewController: UIViewController)
    func show(on viewController: UIViewController)
    func hide(completion: @escaping () -> Void)
}


class DimmingViewController: UIViewController {

    private var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}

extension DimmingViewController: DimmingViewControllerProtocol {
    func present(on viewController: UIViewController) {
        viewController.presentedViewController?.dismiss(animated: true)
        self.modalPresentationStyle = .overFullScreen
        viewController.present(self, animated: true)
    }
    
    func show(on viewController: UIViewController) {
        viewController.addChild(self)
        self.view.frame = viewController.view.frame
        viewController.view.addSubview(self.view)
        self.didMove(toParent: viewController)
    }

    func hide(completion: @escaping () -> Void = {}) {
        if isModal {
            dismiss(animated: true, completion: completion)
        } else {
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
            completion()
        }
    }
}
