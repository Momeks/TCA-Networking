//
//  UserItem.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 11.05.25.
//

import SwiftUI

struct UserItem: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(user.name)
                .bold()
            
            Text(user.username)
                .foregroundStyle(.secondary)
            
            Group {
                Label(user.phone, systemImage: "phone.fill")
                Label(user.address.city, systemImage: "mappin")
                Label(user.email, systemImage: "envelope.fill")
            }
            .imageScale(.small)
            .symbolRenderingMode(.multicolor)
        }
    }
}

#Preview {
    UserItem(user: User.preview)
}
