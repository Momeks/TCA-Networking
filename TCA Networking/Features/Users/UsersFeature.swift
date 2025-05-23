//
//  UsersFeature.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 11.05.25.
//

import ComposableArchitecture
import NetworkKit
import Foundation

//MARK: - User Model
struct User: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
    
    struct Address: Codable, Equatable {
        var street: String
        var suite: String
        var city: String
        var zipcode: String
        var geo: Geo
        
        struct Geo: Codable, Equatable {
            var lat: String
            var lng: String
        }
    }
    
    struct Company: Codable, Equatable {
        var name: String
        var catchPhrase: String
        var bs: String
    }
}

//MARK: - Reducer
@Reducer
struct UsersFeature {
    @Dependency(\.networkService) var networkService
    
    //MARK: - State
    @ObservableState
    struct State: Equatable {
        var users: [User] = []
        var isLoading: Bool = false
        var errorMessage: String?
        
        @Presents var userDetailNavigation: UserDetailFeature.State?
        @Presents var alert: AlertState<AlertAction>?
        
        // Alert actions
        enum AlertAction: Equatable {
            case dismiss
        }
    }
    
    //MARK: - Action
    enum Action {
        case fetchUsers
        case usersResponse(Result<[User], NetworkError>)
        case userTapped(User)
        case showUserAlert(User)
        
        case alert(PresentationAction<State.AlertAction>)
        case userDetailNavigation(PresentationAction<UserDetailFeature.Action>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchUsers:
                state.isLoading = true
                state.errorMessage = nil
                /// [networkService] clearly defines dependencies the closure needs, making it safer and more testable.
                return .run { [networkService] send in
                    do {
                        let users: [User] = try await networkService.fetch(from: UsersEndpoint())
                        await send(.usersResponse(.success(users)))
                    } catch let error as NetworkError {
                        await send(.usersResponse(.failure(error)))
                    } catch {
                        await send(.usersResponse(.failure(.invalidResponse)))
                        print(error.localizedDescription)
                    }
                }
                
            case .usersResponse(.success(let users)):
                state.isLoading = false
                state.users = users
                return .none
                
            case .usersResponse(.failure(let error)):
                state.isLoading = false
                state.errorMessage = error.userMessage
                return .none
                
            case .userTapped(let user):
                state.userDetailNavigation = UserDetailFeature.State(user: user)
                return .none
                
            case .showUserAlert(let user):
                state.alert = AlertState(title: {
                    TextState("Contact Info")
                }, actions: {
                    ButtonState(role: .cancel, action: .dismiss, label: {
                        TextState("Dismiss")
                    })
                }, message: {
                    TextState("\(user.phone)\n\(user.email)")
                })
                return .none
                
            case .alert(.presented(.dismiss)):
                state.alert = nil
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$userDetailNavigation, action: \.userDetailNavigation) {
            UserDetailFeature()
        }
        .ifLet(\.$alert, action: \.alert)
    }
}

// MARK: - Preview
#if DEBUG
extension User {
    static var preview: User {
        User(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "Sincere@april.biz",
            address: User.Address(
                street: "Kulas Light",
                suite: "Apt. 556",
                city: "Gwenborough",
                zipcode: "92998-3874",
                geo: User.Address.Geo(
                    lat: "-37.3159",
                    lng: "81.1496"
                )
            ),
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: User.Company(
                name: "Romaguera-Crona",
                catchPhrase: "Multi-layered client-server neural-net",
                bs: "harness real-time e-markets"
            )
        )
    }
}
#endif
