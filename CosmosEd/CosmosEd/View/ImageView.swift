//
//  ImageView.swift
//  CosmosEd
//
//  Created by Hang Vu on 11/9/2024.
//

import SwiftUI
import AVKit


struct ImageView: View {
    //  MARK: - Properties
    
    @ObservedObject var viewModel: PlanetViewModel;
    @ObservedObject var planetAPI = MediaObjectAPI()
    
    //  MARK: Keep track of the search input
    @State private var searchText = ""
    
    
    // Filters the media based on search text, returns the full list if search text is empty
    var filteredPlanets: [MediaObjectItem] {
        if searchText.isEmpty {
            return planetAPI.planets
        } else {
            return planetAPI.planets.filter { item in
                let title = item.data[0].title.lowercased()
                return title.contains(searchText.lowercased())
            }
        }
    }
    
    //  MARK: - BODY
    var body: some View {
        ZStack {
            BGM_Color
            
            //  MARK: - IMAGE
            ScrollView(.vertical) {
                
                VStack (alignment: .leading) {
                    //  DISPLAYING TITLE'S LABEL
                    HStack(spacing: 5) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                            .padding(.trailing, 8)
                        
                        
                        Text("Images")
                            .font(.system(size: 27, weight: .medium, design: .rounded))
                            .tracking(2.00)
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color(hex: 0x8e8e93))
                        //                        Spacer()
                    }// HSTACK 1
                    .padding()
                    
                    //                    Image("MercuryImage")
                    //                        .resizable()
                    //                        .opacity(0.7)
                    //                        .aspectRatio(contentMode: .fill)
                    //                        .frame(width: 360, height: 200)
                    //                        .cornerRadius(60)
                    //                        .overlay(
                    //                            RoundedRectangle(cornerRadius: 60)
                    //                                .stroke(Color(hex: 0xc7c7cc), lineWidth: 1)
                    //                        )
                    //                        .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
                    //                        .padding()
                    
                    //  MARK: Images/Videos List
                    // List of planets
                    ForEach(filteredPlanets, id: \.data[0].nasaID) { item in
                        
                        //  CAS
                        VStack(alignment: .leading) {
                            
                                Text(item.data[0].title)
                                    .font(.headline)
                                
                                Text("Date: \(item.data[0].dateCreated)")
                                    .font(.footnote)
    
                            if item.href.contains("/image/"){
                                
                                //  Display image
                                if let link = item.links?.first(where: { $0.render == "image" || $0.href.hasSuffix(".jpg") }) {
                                    AsyncImage(url: URL(string: link.href)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 360, height: 200)
                                            .cornerRadius(30)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 30)
                                                    .stroke(Color(hex: 0xc7c7cc), lineWidth: 1)
                                            )
                                            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
                                            .padding()
                                    } placeholder: {
                                        ProgressView()
                                        // Shows a loading spinner while the image is loading
                                    }
                                }
                            }
                        }
                    }
                    
                }// End Of VStack 2
                
            }// (I) End Of ScrollView
            //  Highlighting the box
            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
            .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.11), radius: 6, x: 0, y: 8)
            
            
            //  MARK: Uncomment this one to fetch Data
//            .onAppear {
//                planetAPI.fetchMediaObjects(searchQuery: viewModel.currentPlanet) // Example query
//            }
            
        }
    }
}

//  MARK: - Previews
#Preview {
    ImageView(viewModel: PlanetViewModel())
}
