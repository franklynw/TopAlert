//
//  TopAlert+Modifiers.swift
//  
//
//  Created by Franklyn Weber on 30/03/2021.
//

import SwiftUI


extension TopAlert {
    
    public func dismiss(_ dismiss: Binding<Bool>) -> Self {
        
        _ = Binding<Bool>(
            get: {
                if dismiss.wrappedValue {
                    TopAlertPresenter.dismiss()
                    dismiss.wrappedValue = false
                }
                return dismiss.wrappedValue
            }, set: { _ in }
        )
        
        return self
    }
}


extension View {
    
    /// View extension in the style of .sheet
    /// - Parameters:
    ///   - alertConfig: binding to an alertConfig - the alert will be preented when the config is not nil
    public func topAlert(alertConfig: Binding<TopAlert.AlertConfig?>) -> some View {
        modifier(TopAlertPresentationModifier(content: { TopAlert(alertConfig: alertConfig) }))
    }
}


struct TopAlertPresentationModifier: ViewModifier {
    
    var content: () -> TopAlert
    
    init(@ViewBuilder content: @escaping () -> TopAlert) {
        self.content = content
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            self.content()
        }
    }
}
