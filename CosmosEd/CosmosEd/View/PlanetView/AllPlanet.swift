import SwiftUI

//  DISPLAY ALL INFORMATION

struct AllPlanet: View {
    //  MARK: - Properties
    @ObservedObject var infoAPI = InfoAPI() // Observe the API class for changes
    @ObservedObject var viewModel: PlanetViewModel   //  Viewmodel to track selected planet
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            BGM_Color
            
            // MARK: - GENERAL INFORMATION
            ScrollView(.vertical) {
                
                // Check if planets data is available
                if infoAPI.planets.isEmpty {
                    Text("Loading Planets...")
                        .font(.title)
                        .padding()
                        .foregroundStyle(Color(hex: 0xc7c7cc))
                } else {
                    // Iterate over the planets fetched by the API
                    
                    //  MARK: UNCOMMENT THIS ONE TO DISPLAY SINGLE PLANET
//                    if let planet = infoAPI.planets.first(where: { $0.name == viewModel.currentPlanet}) { VStack(alignment: .leading) ..... }
                    
                    //  MARK: DISPLAY SINGLE PLANET
                    ForEach(infoAPI.planets, id: \.name) { planet in
                        VStack(alignment: .leading) {
                            HStack {
                                // Display planet image and details
                                VStack {
                                    ZStack {
                                        // Background with rounded corners
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
                                            // Name Label
                                            Text(planet.name)
                                                .font(.system(size: 25, weight: .medium, design: .rounded))
                                                .tracking(2.0)
                                                .padding(12)
                                                .frame(width: 230, alignment: .leading)
                                                .foregroundStyle(.black.opacity(0.65))
                                                .background(Color(hex: 0xaeaeb2)) // Background for Name Label
                                                .cornerRadius(32, corners: [.topLeft, .topRight])
                                            
                                            // Details about the planet
                                            VStack(alignment: .leading, spacing: 18) {
                                                // Mass
                                                HStack {
                                                    Image(systemName: "scalemass.fill")
                                                        .font(.system(size: 22))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                    
                                                    Text("Mass:")
                                                        .font(.system(size: 17))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(planet.mass ?? 0)")
                                                        .font(.system(size: 17))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                }
                                                
                                                // Period
                                                HStack {
                                                    Image(systemName: "circle.dotted.and.circle")
                                                        .font(.system(size: 22))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                    
                                                    Text("Period:")
                                                        .font(.system(size: 17))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(planet.period ?? 0)")
                                                        .font(.system(size: 17))
                                                        .foregroundColor(Color(hex: 0xe5e5ea))
                                                }
                                            }
                                            .padding(.horizontal, 10)
                                            
                                        }
                                        .padding(30) // PADDING The text inside
                                        .offset(y: -15)
                                    }
                                }
                                
                                Image(planet.assetImageName)
                                    .resizable()
                                    .frame(width: 130, height: 130)
                                    .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.22), radius: 34, x: 0, y: -16)
                                    .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.25), radius: 24, x: 0, y: 2)
                                    .offset(x: -25)
                            }
                        }
                        .padding(.vertical, 10)
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
