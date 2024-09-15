import SwiftUI

//  DISPLAY List of planets' INFORMATION

struct AllPlanet: View {
    //  MARK: - Properties
    @ObservedObject var infoAPI = InfoAPI() // Observes changes from InfoAPI, which handles API requests
    @ObservedObject var viewModel: PlanetViewModel   //  ViewModel to track selected planet and related logic
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            
            //  Background gradient or color for the view
            BGM_Color
            
            // MARK: - GENERAL INFORMATION
            ScrollView(.vertical) {
                
                // Check if planets data is available
                if infoAPI.planets.isEmpty {
                    
                    // Display a loading message while data is being fetched
                    Text("Loading Planets...")
                        .font(.title)
                        .padding()
                        .foregroundStyle(Color(hex: 0xc7c7cc))
                } else {
                    //  Iterate over the planets fetched by the API and display their details
                    
                    //  MARK: UNCOMMENT THIS BLOCK TO DISPLAY SINGLE PLANET
                    //  If want to display only one planet based on `viewModel.currentPlanet`, uncomment this block
                    //  if let planet = infoAPI.planets.first(where: { $0.name == viewModel.currentPlanet}) { VStack(alignment: .leading) ..... }
                    
                    //  MARK:   DISPLAY MULTIPLE PLANETS
                    //  Iterate over all planets fetched from the API and display their details
                    ForEach(infoAPI.planets, id: \.name) { planet in
                        VStack(alignment: .leading) {
                            
                            // Display planet image and details side by side
                            HStack {
                                // Display planet image and details
                                VStack {
                                    ZStack {
                                        //  Background for planet details with rounded corners
                                        RoundedRectangle(cornerRadius: 32)
                                            .fill(Color.white.opacity(0.22))
                                            .frame(width: 230, height: 156)
                                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 32)
                                                    .stroke(Color(hex: 0xd1d1d6), lineWidth: 1)
                                            )
                                        
                                        // Overlay content - Planet details
                                        VStack(alignment: .leading) {
                                            
                                            // MARK: Display planet name
                                            Text(planet.name)
                                                .font(.system(size: 25, weight: .medium, design: .rounded))
                                                .tracking(2.0)
                                                .padding(12)
                                                .frame(width: 230, alignment: .leading)
                                                .foregroundStyle(.black.opacity(0.65))
                                                .background(Color(hex: 0xaeaeb2)) // Background for Name Label
                                                .cornerRadius(32, corners: [.topLeft, .topRight]) // Rounded corners for top
                                            
                                            // MARK: Details about the planet (mass and period)
                                            VStack(alignment: .leading, spacing: 18) {
                
                                                // Mass information
                                                HStack {
                                                    
                                                    // Icon for mass
                                                    Image(systemName: "scalemass.fill")
                                                        .font(.system(size: 22))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                    
                                                    // Mass label
                                                    Text("Mass:")
                                                        .font(.system(size: 17))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                    
                                                    Spacer()
                                                    
                                                    // Display the mass value, default to 0 if `mass` is nil
                                                    Text("\(planet.mass ?? 0)")
                                                        .font(.system(size: 17))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                }
                                                
                                                // Period Information
                                                HStack {
                                                    // Icon for period
                                                    Image(systemName: "circle.dotted.and.circle")
                                                        .font(.system(size: 22))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                    
                                                    // Period label
                                                    Text("Period:")
                                                        .font(.system(size: 17))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                    
                                                    Spacer()
                                                    
                                                    // Display the period value, default to 0 if `period` is nil
                                                    Text("\(planet.period ?? 0)")
                                                        .font(.system(size: 17))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                }
                                            }
                                            // Add horizontal padding for text
                                            .padding(.horizontal, 10)
                                            
                                        }
                                        .padding(30) // PADDING The text inside the card
                                        .offset(y: -15) // Offset to adjust position of content
                                    }
                                }
                                
                                // MARK: Planet image
                                Image(planet.assetImageName)
                                    .resizable()
                                    .frame(width: 130, height: 130)
                                    .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.22), radius: 34, x: 0, y: -16) // Top shadow
                                    .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.25), radius: 24, x: 0, y: 2) // Bottom shadow
                                    .offset(x: -25) // Offset the image to the left
                            }
                        }
                        .padding(.vertical, 10) // Vertical padding between planets
                    }
                }
            }
            //  MARK: Uncomment this one to fetch data
            .onAppear {
                infoAPI.fetchSolarSystemPlanets() // Call the API on view load
            }
        }
    }
}

//  MARK: - Preview
#Preview {
    AllPlanet(viewModel: PlanetViewModel())
}
