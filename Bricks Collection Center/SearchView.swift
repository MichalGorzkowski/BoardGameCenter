//
//  SearchView.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 09/01/2024.
//

import SwiftUI
import Foundation

struct SearchView: View {
    @State private var legoSets: LegoSetList?
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            Text("SearchView")
            
            TextField("Search LEGO Sets", text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Search LEGO Sets") {
                let rebrickableAPIClient = RebrickableAPIClient()
                rebrickableAPIClient.searchLegoSetsByName(searchText: searchText) { result in
                                    switch result {
                                    case .success(let legoSetList):
                                        self.legoSets = legoSetList
                                        print(legoSets)
                                    case .failure(let error):
                                        print("Error: \(error)")
                                    }
                                }
            }
            .padding()
            
            List(legoSets?.results ?? []) { legoSet in
                            VStack(alignment: .leading) {
                                Text(legoSet.name)
                                    .font(.headline)
                                Text("Set Number: \(legoSet.setNum)")
                                Text("Year: \(legoSet.year)")

                                if let imageURL = legoSet.setImgURL {
                                    AsyncImage(url: imageURL) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100)
                                        case .failure:
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100)
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                }

                                Text("Last Modified: \(legoSet.lastModifiedDt)")
                            }
                            .padding()
                        }
        }
        
        
        
        
    }
}

#Preview {
    SearchView()
}
