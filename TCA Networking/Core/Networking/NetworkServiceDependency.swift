//
//  NetworkServiceDependency.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 11.05.25.
//

import ComposableArchitecture
import Foundation
import NetworkKit

private enum NetworkServiceKey: DependencyKey {
    static var liveValue: NetworkService {
        URLSessionNetworkService()
    }
    
    static var previewValue: NetworkService {
        MockNetworkService()
    }
    
    static var testValue: NetworkService {
        MockNetworkService()
    }
}

extension DependencyValues {
    var networkService: NetworkService {
        get { self[NetworkServiceKey.self] }
        set { self[NetworkServiceKey.self] = newValue }
    }
}
