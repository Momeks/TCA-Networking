//
//  UserItem.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 11.05.25.
//

import SwiftUI

struct UserItem: View {
    var user: User
    var action: (() -> Void)?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(user.name)
                    .bold()
                
                Text(user.username)
                    .foregroundStyle(.secondary)
                
                Button("Contact Info", systemImage: "info.circle") {
                    action?()
                }
                .tint(.blue)
                .imageScale(.small)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    UserItem(user: User.preview)
        .padding(.horizontal)
}
