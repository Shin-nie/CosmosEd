//
//  VideoView.swift
//  CosmosEd

import SwiftUI
import AVKit

struct VideoView: View {
    //  MARK: - Properties
    @ObservedObject var viewModel: PlanetViewModel;
    @ObservedObject var planetAPI = MediaObjectAPI()
    @State var videoLinks: [MediaObjectItem] = []
    
//    //  MARK: Keep track of the search input
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
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            BGM_Color
            
            //  MARK: - VIDEO
            ScrollView(.vertical) {
                
                VStack (alignment: .leading) {

                    //  MARK: SearchBar for Search Input
                    // Search bar bound to `viewModel.searchText`
                    SearchBar(text: $searchText, placeholder: "Search for videos...")
                
                    //  MARK: Title's Lable
                    SectionHeader(iconName: "play.rectangle.fill", title: "Videos", trailingIconName: "chevron.down")
                    
                    //  MARK: Video for Placeholder
                    MediaView(imageName: "mercuryNasa", iconOverlay: "arrowtriangle.forward.circle.fill", cornerRadius: 30)
                        .padding(.bottom, 20)
                    
                    
                    // Check if planets data is available
                    if planetAPI.planets.isEmpty {
                        Text("Loading Videos...")
                            .font(.title)
                            .padding()
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                        
                    } else {
                        //  MARK: Images/Videos List
                        // List of planets
                        // Display the filtered media items
                        ForEach(filteredPlanets, id: \.data[0].nasaID) { item in
                            
                            //  CAS
                            VStack(alignment: .leading) {
                                
                                if item.href.contains("/image/"){
                                    
                                    //  Display image
    //                                if let link = item.links?.first(where: { $0.render == "image" || $0.href.hasSuffix(".jpg") }) {
    //                                    AsyncImage(url: URL(string: link.href)) { image in
    //                                        image
    //                                            .resizable()
    //                                            .aspectRatio(contentMode: .fill)
    //                                            .frame(width: 360, height: 200)
    //                                            .cornerRadius(30)
    //                                            .overlay(
    //                                                RoundedRectangle(cornerRadius: 30)
    //                                                    .stroke(Color(hex: 0xc7c7cc), lineWidth: 1)
    //                                            )
    //                                            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
    //                                            .padding()
    //                                    } placeholder: {
    //                                        ProgressView()
    //                                        // Shows a loading spinner while the image is loading
    //                                    }
    //                                }
                                }
                                
                                
                                // Display video
                                if item.href.contains("/video/"){
                                    //  Media Title
                                    Text(item.data[0].title)
                                        .foregroundStyle(.white)
                                        .opacity(0.8)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                    
                                    Text("Date: \(item.data[0].dateCreated)")
                                        .foregroundStyle(.white)
                                        .font(.footnote)
                                        .fontWeight(.light)
                                        .padding(.horizontal)
                                    
                                    VideoPlayer(player: AVPlayer(url: URL(string: convertToHTTPS(urlString: "https://images-assets.nasa.gov/video/\(item.data[0].nasaID)/\(item.data[0].nasaID)~mobile.mp4"))!))

                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 360, height: 200)
                                        .cornerRadius(30)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color(hex: 0xc7c7cc), lineWidth: 1)
                                        )
                                        .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
                                        .padding()
                                        .padding(.bottom, 15)
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
            
//             MARK: Uncomment this one to fetch Data
            .onAppear {
                planetAPI.fetchMediaObjects(searchQuery: viewModel.currentPlanet)
            }
            
        }
    }
}

//  MARK: - Previews
#Preview {
    VideoView(viewModel: PlanetViewModel())
}
