//
//  VideoView.swift
//  CosmosEd

import SwiftUI
import AVKit

struct VideoView: View {
    //  MARK: - Properties
    @ObservedObject var viewModel: PlanetViewModel; // Observes changes from the ViewModel to get the selected planet
    @ObservedObject var planetAPI = MediaObjectAPI() // Observes the API class for fetching media objects (videos and images)
    @State var videoLinks: [MediaObjectItem] = [] // Holds the list of video media objects
    
    //  MARK: Keep track of the search input
    @State private var searchText = ""
    // State to hold the search text entered by the user
    
    
    // Filters the media based on search text, returns the full list if search text is empty
    var filteredPlanets: [MediaObjectItem] {
        if searchText.isEmpty {
            return planetAPI.planets // Return the full list if no search text
        } else {
            return planetAPI.planets.filter { item in
                let title = item.data[0].title.lowercased() // Convert the title to lowercase for case-insensitive search
                return title.contains(searchText.lowercased()) // Return items where the title contains the search text
            }
        }
    }
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            
            // Background color
            BGM_Color
            
            //  MARK: - VIDEO
            ScrollView(.vertical) { // Scrollable vertical view to list videos
                
                VStack (alignment: .leading) {

                    //  MARK: SearchBar for Search Input
                    // Search bar bound to `viewModel.searchText`
                    SearchBar(text: $searchText, placeholder: "Search for videos...")
                
                    //  MARK: Title's Lable
                    // Section header with a play icon and "Videos" label
                    SectionHeader(iconName: "play.rectangle.fill", title: "Videos", trailingIconName: "chevron.down")
                    
                    //  MARK: Video for Placeholder
                    // A placeholder video or image to be displayed
                    MediaView(imageName: "mercuryNasa", iconOverlay: "arrowtriangle.forward.circle.fill", cornerRadius: 30)
                        .padding(.bottom, 20)
                    
                    
                    // Check if planets data is available
                    if planetAPI.planets.isEmpty {
                        // Show loading text if the data hasn't been fetched yet
                        Text("Loading Videos...")
                            .font(.title)
                            .padding()
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                        
                    } else {
                        //  MARK: Images/Videos List
                        // Display the filtered media items (filteredPlanets)
                        // List of planets
                        // Display the filtered media items
                        ForEach(filteredPlanets, id: \.data[0].nasaID) { item in
                            
                            //  CAS
                            VStack(alignment: .leading) {
                                
                                // Check if the media item is an image
                                if item.href.contains("/image/"){
                                    
                                    // Uncomment the code to display images if needed
                                    
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
                                    //  Display the media title
                                    Text(item.data[0].title)
                                        .foregroundStyle(.white)
                                        .opacity(0.8)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                    
                                    //  Display the date created
                                    Text("Date: \(item.data[0].dateCreated)")
                                        .foregroundStyle(.white)
                                        .font(.footnote)
                                        .fontWeight(.light)
                                        .padding(.horizontal)
                                    
                                    // Video player for playing the video
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
            //  Apply shadows to the scrollable box - Highlighting
            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
            .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.11), radius: 6, x: 0, y: 8)
            
//             MARK: Uncomment this one to fetch Data
            .onAppear {
                planetAPI.fetchMediaObjects(searchQuery: viewModel.currentPlanet) // Fetch media based on the selected planet
            }
            
        }
    }
}

//  MARK: - Previews
#Preview {
    VideoView(viewModel: PlanetViewModel())
}
