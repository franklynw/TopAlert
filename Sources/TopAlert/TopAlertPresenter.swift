//
//  TopAlertPresenter.swift
//  
//
//  Created by Franklyn Weber on 30/03/2021.
//

import SwiftUI


class TopAlertPresenter {
    
    private static var window: UIWindow?
    private static var viewController: UIViewController?
    private static var alertController: UIAlertController?
    
    private static var parent: TopAlert?
    
    static func present(parent: TopAlert) {
        
        guard let appWindow = UIApplication.window else {
            return
        }
        guard window == nil else {
            return
        }
        guard let alertConfig = parent.alertConfig else {
            return
        }
        
        if let windowScene = appWindow.windowScene {
            
            let newWindow = UIWindow(windowScene: windowScene)
            
            let viewController = UIViewController()
            viewController.view.backgroundColor = .clear
            
            newWindow.rootViewController = viewController

            self.viewController = viewController
            
            window = newWindow
            window?.alpha = 0
            window?.makeKeyAndVisible()
            
            let alertController = UIAlertController(title: alertConfig.title, message: alertConfig.message, preferredStyle: alertConfig.style)
            
            alertConfig.buttons.forEach {
                let action = $0.alertAction {
                    finished()
                }
                alertController.addAction(action)
            }
            
            self.alertController = alertController
            
            UIView.animate(withDuration: 0.3) {
                window?.alpha = 1
                viewController.present(alertController, animated: true, completion: nil)
            }
            
            self.parent = parent
        }
    }
    
    static func dismiss() {
        alertController?.dismiss(animated: true, completion: nil)
        finished()
    }
    
    private static func finished() {
        
        guard window != nil else {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            window?.alpha = 0
            viewController?.view.alpha = 0
        } completion: { _ in
            window = nil
            viewController = nil
            parent?.alertConfig = nil
        }
    }
}
