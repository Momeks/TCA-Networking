//
//  TCA_NetworkingApp.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 11.05.25.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_NetworkingApp: App {
    static let store = Store(initialState: UsersFeature.State()) {
        UsersFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            UsersView(store: TCA_NetworkingApp.store)
        }
    }
}
