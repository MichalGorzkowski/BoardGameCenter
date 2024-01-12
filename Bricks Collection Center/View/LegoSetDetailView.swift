//
//  LegoSetDetailView.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 09/01/2024.
//

import SwiftUI

struct LegoSetDetailView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    let legoSet: LegoSet
    @State var showingSetAddedAlert = false

    var body: some View {
        VStack {
            Text(legoSet.name)
                .font(.title)
                .padding()

            if let imageURL = legoSet.setImgURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding()
            }
            
            HStack (spacing: 50) {
                VStack {
                    Image("hash")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.bottom, -20)
                    Text("\(legoSet.setNum)")
                        .font(.system(size: 30))
                    Text("Set Number")
                        .font(.system(size: 15))
                }
                
                VStack {
                    Image("piece")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.bottom, -20)
                    Text("\(legoSet.numParts)")
                        .font(.system(size: 30))
                    Text("Elements")
                        .font(.system(size: 15))
                }
            }
            
            Text("Year: \(legoSet.year)")
                .padding()
                .font(.system(size: 15))

            Text("Last Modified:\n\(legoSet.lastModifiedDt)")
                .multilineTextAlignment(.center)
                .padding()
                .font(.system(size: 9))

            Spacer()
            
            Button(action: {
                firebaseManager.addSetToCollection(legoSet: legoSet)
                showingSetAddedAlert = true
            }, label: {
                Text("Add to collection")
                    .foregroundColor(.blue)
                    .padding()
            })
            .alert("Set added to your collection", isPresented: $showingSetAddedAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

#Preview {
    LegoSetDetailView(legoSet: LegoSet(setNum: "0011-3", name: "Castle 2 for 1 Bonus Offer", year: 1987, themeId: 199, numParts: 0, setImgURL: URL(string: "https://example.com/sample_image.jpg")!, setURL: URL(string: "https://rebrickable.com/sets/0011-3/castle-2-for-1-bonus-offer/")!, lastModifiedDt: "2012-04-01T04:47:31.488559Z"))
}
