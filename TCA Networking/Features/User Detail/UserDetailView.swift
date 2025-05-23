//
//  UserDetailView.swift
//  TCA Networking
//
//  Created by Mohammad Komeili on 12.05.25.
//

import SwiftUI
import MapKit
import ComposableArchitecture

struct UserDetailView: View {
    let store: StoreOf<UserDetailFeature>
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Label(store.user.username, systemImage: "person.crop.circle")
                    Label(store.user.email, systemImage: "at")
                    Label(store.user.website, systemImage: "globe")
                    Label(store.user.phone, systemImage: "phone")
                } header: {
                    Text("Contact Information")
                }
                
                Section {
                    Label(store.user.company.name, systemImage: "briefcase")
                    Label(store.user.company.bs, systemImage: "text.bubble")
                    Label(store.user.company.catchPhrase, systemImage: "note.text")
                } header: {
                    Text("Company")
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Label([
                            store.user.address.suite,
                            store.user.address.street,
                            store.user.address.city,
                            "\nZip code: \(store.user.address.zipcode)"
                        ].compactMap { $0 }.joined(separator: ", "),
                              systemImage: "building.2")
                        
                        if let coordinate = store.coordinate {
                            Map(initialPosition: .region(MKCoordinateRegion(
                                center: coordinate.value,
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            ))) {
                                Marker("", coordinate: coordinate.value)
                            }
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                    
                } header: {
                    Text("Location")
                }
            }
            .navigationTitle(store.user.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Actions", systemImage: "ellipsis.circle") {
                        Button("Call", systemImage: "phone") {
                            store.send(.onCallPhoneNumber)
                        }
                        
                        Button("Send Email", systemImage: "envelope") {
                            store.send(.onSendEmail)
                        }
                        
                        Button("Open Website", systemImage: "globe") {
                            store.send(.onOpenWebsite)
                        }
                        
                        Button("Open Map", systemImage: "map") {
                            store.send(.onOpenMap)
                        }
                    }
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    UserDetailView(
        store: Store(initialState: UserDetailFeature.State(user: User.preview)) {
            UserDetailFeature()
        }
    )
}
