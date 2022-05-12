//
//  TopAlert.AlertConfig.swift
//  
//
//  Created by Franklyn Weber on 30/03/2021.
//

import SwiftUI


extension TopAlert {
    
    public struct AlertConfig {
        let title: String?
        let message: String?
        let buttons: [ButtonType]?
        let style: UIAlertController.Style
        
        public enum ButtonType {
            case `default`(title: String, action: () -> () = {})
            case destructive(title: String, action: () -> () = {})
            case ok(action: () -> () = {})
            case cancel(action: () -> () = {})
            
            func alertAction(withFinished finished: @escaping () -> ()) -> UIAlertAction {
                switch self {
                case .default(let title, let action):
                    return UIAlertAction(title: title, style: .default) { _ in
                        action()
                        finished()
                    }
                case .destructive(let title, let action):
                    return UIAlertAction(title: title, style: .destructive) { _ in
                        action()
                        finished()
                    }
                case .ok(let action):
                    return UIAlertAction(title: NSLocalizedString("OK", bundle: .module, comment: "OK"), style: .default) { _ in
                        action()
                        finished()
                    }
                case .cancel(let action):
                    return UIAlertAction(title: NSLocalizedString("Cancel", bundle: .module, comment: "OK"), style: .cancel) { _ in
                        action()
                        finished()
                    }
                }
            }
        }
        
        public init(title: String?, message: String? = nil, buttons: [ButtonType]? = nil, style: UIAlertController.Style = .alert) {
            self.title = title
            self.message = message
            self.buttons = buttons
            self.style = style
        }
        
        public init(title: String?, message: String? = nil, style: UIAlertController.Style = .alert, action: @escaping () -> ()) {
            self.title = title
            self.message = message
            self.buttons = [.ok(action: action)]
            self.style = style
        }
    }
}
