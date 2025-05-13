//
//  UserDetailFeature.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 12.05.25.
//

import ComposableArchitecture
import Foundation
import UIKit
import MapKit

@Reducer
struct UserDetailFeature {
    @ObservableState
    struct State: Equatable {
        var user: User
        var coordinate: UserCoordinate?
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
                if let lat = Double(state.user.address.geo.lat),
                   let lng = Double(state.user.address.geo.lng) {
                    state.coordinate = UserCoordinate(value: CLLocationCoordinate2D(latitude: lat, longitude: lng))
                }
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

struct UserCoordinate: Equatable {
    var value: CLLocationCoordinate2D
    
    static func == (lhs: UserCoordinate, rhs: UserCoordinate) -> Bool {
        lhs.value.latitude == rhs.value.latitude &&
        lhs.value.longitude == rhs.value.longitude
    }
}
