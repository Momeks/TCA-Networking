//
//  UsersView.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 11.05.25.
//

import SwiftUI
import ComposableArchitecture

struct UsersView: View {
    let store: StoreOf<UsersFeature>
    
    var body: some View {
        NavigationStack {
            ZStack {
                if store.isLoading {
                    ProgressView()
                } else {
                    List(store.users) { user in
                        NavigationLink(state: UserDetailFeature.State(user: user)) {
                            UserItem(user: user)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("refresh", systemImage: "arrow.clockwise") {
                        Task {
                            store.send(.fetchUsers)
                        }
                    }
                }
            }
        }
        .task {
            store.send(.fetchUsers)
        }
        .navigationDestination(store: self.store.scope(state: \.$userDetail, action: \.userDetail)) {
            UserDetailView(store: $0)
        }
    }
}

#Preview {
    UsersView(
        store: Store(initialState: UsersFeature.State()) {
            UsersFeature()
        }
    )
}
