//
//  UserDetailView.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 12.05.25.
//

import SwiftUI
import ComposableArchitecture

struct UserDetailView: View {
    let store: StoreOf<UserDetailFeature>
    
    var body: some View {
        Text(store.user.name)
    }
}

#Preview {
    UserDetailView(
        store: Store(initialState: UserDetailFeature.State(user: User.preview)) {
            UserDetailFeature()
        }
    )
}
