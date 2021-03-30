//
//  DoIfLet.swift
//  
//
//  Created by Franklyn Weber on 30/03/2021.
//

import SwiftUI


struct DoIfLet<T>: View {
    
    private var binding: Binding<T?>
    private let action: (T) -> ()
    
    
    init(_ item: Binding<T?>, _ action: @escaping (T) -> ()) {
        binding = item
        self.action = action
    }
    
    var body: some View {
        
        return IfLet(binding) { item -> EmptyView in
            self.action(item)
            return EmptyView()
        }
    }
}


struct IfLet: View {
    
    private let viewProvider: () -> AnyView
    
    
    init<T, V: View>(_ item: Binding<T?>, @ViewBuilder _ viewProvider: @escaping (T) -> V) {
        self.viewProvider = {
            AnyView(item.wrappedValue.map {
                viewProvider($0)
            })
        }
    }
    
    var body: some View {
        return viewProvider()
    }
}
