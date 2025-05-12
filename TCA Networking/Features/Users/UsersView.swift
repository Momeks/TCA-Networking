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
                        Button {
                            store.send(.userTapped(user))
                        } label: {
                            UserItem(user: user)
                        }
                        .tint(.primary)
                    }
                }
            }
            .navigationTitle("Users")
            .navigationDestination(
              store: store.scope(state: \.$userDetail, action: \.userDetail)
            ) {
              UserDetailView(store: $0)
            }
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
    }
}

#Preview {
    UsersView(
        store: Store(initialState: UsersFeature.State()) {
            UsersFeature()
        }
    )
}

//MARK: - Tips
/*
 NavigationLink(destination: EmptyView()) {
     UserItem(user: user)
 }
 .onTapGesture {
     store.send(.userTapped(user))
 }
 */
