//
//  UserDetailFeature.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 12.05.25.
//

import ComposableArchitecture
import Foundation
import UIKit

@Reducer
struct UserDetailFeature {
    @ObservableState
    struct State: Equatable {
        var user: User
    }
    
    enum Action {
        case onAppear
        case onOpenMap
        case onOpenWebsite
        case onCallPhoneNumber
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .onOpenMap:
                return .none
                
            case .onOpenWebsite:
                if let url = URL(string: state.user.website) {
                    UIApplication.shared.open(url, options: [:])
                }
                return .none
                
            case .onCallPhoneNumber:
                if let phoneNumber = URL(string: "tel://\(state.user.phone)") {
                    UIApplication.shared.open(phoneNumber, options: [:])
                }
                return .none
            }
        }
    }
}
