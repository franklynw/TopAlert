//
//  TopAlert.swift
//  Simplist
//
//  Created by Franklyn Weber on 30/03/2021.
//

import SwiftUI


public struct TopAlert: View {
    
    @Binding var alertConfig: AlertConfig?
    
    public init(alertConfig: Binding<AlertConfig?>) {
        _alertConfig = alertConfig
    }
    
    public var body: some View {
        
        DoIfLet($alertConfig) { _ in
            present()
        }
    }
    
    private func present() {
        TopAlertPresenter.present(parent: self)
    }
}
