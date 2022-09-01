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
        let finishedAction: (() -> ())?
        
        public enum ButtonType {
            case `default`(title: String, action: () -> () = {})
            case destructive(title: String, action: () -> () = {})
            case ok(title: String? = nil, action: () -> () = {})
            case cancel(title: String? = nil, action: () -> () = {})
            
            internal func alertAction(withFinished finished: @escaping () -> ()) -> UIAlertAction {
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
                case .ok(let title, let action):
                    return UIAlertAction(title: title ?? NSLocalizedString("OK", bundle: .module, comment: "OK"), style: .default) { _ in
                        action()
                        finished()
                    }
                case .cancel(let title, let action):
                    return UIAlertAction(title: title ?? NSLocalizedString("Cancel", bundle: .module, comment: "OK"), style: .cancel) { _ in
                        action()
                        finished()
                    }
                }
            }
        }
        
        /// If we want to add a finished action after the config has been created (eg, if it's been passed along & is going into an operation queue, we might want to pass in a closure which tells the operation it's done)
        public func withFinishedAction(_ finishedAction: @escaping () -> ()) -> Self {
            return AlertConfig(title: title, message: message, buttons: buttons, style: style, finishedAction: finishedAction)
        }
    }
}


public extension TopAlert.AlertConfig {
    
    init(title: String?, message: String? = nil, buttons: [ButtonType]? = nil, style: UIAlertController.Style = .alert, finished: (() -> ())? = nil) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self.style = style
        self.finishedAction = finished
    }
    
    init(title: String?, message: String? = nil, style: UIAlertController.Style = .alert, action: @escaping () -> (), finished: (() -> ())? = nil) {
        self.title = title
        self.message = message
        self.buttons = [.ok(action: action)]
        self.style = style
        self.finishedAction = finished
    }
}
