//
//  UsersEndpoint.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 11.05.25.
//

import Foundation
import NetworkKit

struct UsersEndpoint: Endpoint {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        return "users"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
}
