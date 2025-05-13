//
//  UserFeatureTests.swift
//  TCA NetworkingTests
//
//  Created by Mohammad Komeili on 13.05.25.
//

import XCTest
import ComposableArchitecture
import NetworkKit

@testable import TCA_Networking

final class UserFeatureTests: XCTestCase {
    var store: TestStore<UsersFeature.State, UsersFeature.Action>!
    var mockService: MockNetworkService!
    let mockUsers = [User.preview]
    
    override func setUp() {
           super.setUp()
           mockService = MockNetworkService()
           mockService.mockData = mockUsers

           store = TestStore(
               initialState: UsersFeature.State(),
               reducer: { UsersFeature() },
               withDependencies: {
                   $0.networkService = mockService
               }
           )
       }
    
    func test_FetchUsers_Success() async {
        await store.send(.fetchUsers) {
            $0.isLoading = true
            $0.errorMessage = nil
        }
        
        await store.receive(\.usersResponse.success) {
            $0.isLoading = false
            $0.users = self.mockUsers
        }
    }
    
    func test_FetchUsers_Failure() async {
        mockService.shouldThrowError = true
        mockService.errorToThrow = .invalidResponse
        
        await store.send(.fetchUsers) {
            $0.isLoading = true
            $0.errorMessage = nil
        }
        
        await store.receive(\.usersResponse.failure) {
            $0.isLoading = false
            $0.errorMessage = NetworkError.invalidResponse.userMessage
        }
    }
    
    func testUserTapped_NavigatesToDetailScreen() async {
        let user = User.preview
        await store.send(.userTapped(user)) {
            $0.userDetailNavigation = UserDetailFeature.State(user: user)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        store = nil
        mockService = nil
    }
}
