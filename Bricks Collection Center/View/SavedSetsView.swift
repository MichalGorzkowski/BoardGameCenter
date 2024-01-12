//
//  SavedSetsView.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 04/01/2024.
//

import SwiftUI

struct SavedSetsView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("SavedSetsView")
                
                List(firebaseManager.setsInCollectionList) { item in
                    NavigationLink(destination: LegoSetDetailView(legoSet: item)) {
                        LegoSetSearchRowView(legoSet: item)
                    }
                }
            }
            .onAppear {
                firebaseManager.getUserSetCollectionListFromFirebase()
            }
        }
    }
}
