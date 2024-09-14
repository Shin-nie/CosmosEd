//
//  PlanetInfoView.swift
//  CosmosEd

import SwiftUI

struct PlanetInfoView: View {
    //  MARK: - Properties
    
    @ObservedObject var infoAPI = InfoAPI() // Observe the API class for changes
    @ObservedObject var viewModel: PlanetViewModel   //  Viewmodel to track selected planet
    
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            BGM_Color
            
            //  MARK: - GENERAL INFORMATION
            ScrollView(.vertical) {
                
                //  MARK: FIRST BOX
                
                //  DISPLAYING TITLE'S LABEL
                SectionHeader(iconName: "info.circle", title: "General Information", trailingIconName: "chevron.down")
                
                //  MARK: NAME SECTION
                // Check if planets data is available
                if infoAPI.planets.isEmpty {
                    Text("Loading Planets...")
                        .font(.title)
                        .padding()
                        .foregroundStyle(Color(hex: 0xc7c7cc))
                    
                } else {
                    // Iterate over the planets fetched by the API
                    if let planet = infoAPI.planets.first(where: { $0.name == viewModel.currentPlanet}) {
                        
                        //  MARK: FIRST BOX
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
                                            .padding(.horizontal, 10) // padding the detailed information
                                            
                                        }
                                        .padding(30) // PADDING The text inside include the white label
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
//                        .padding(.vertical, 10)
                        
                        //  MARK: TEMPERATURE SECTION
                        VStack(alignment: .leading) {
                            VStack {
                                ZStack {
                                    // Background with rounded corners
                                    RoundedRectangle(cornerRadius: 32)
                                        .fill(Color.white.opacity(0.22))
                                        .frame(width: 360, height: 156)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x:0, y:2)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 32)
                                                .stroke(Color(hex: 0xd1d1d6), lineWidth: 1)
                                        )
                                    
                                    // Overlay content - Name box
                                    VStack(alignment: .leading) {
                                        // Time Label on top
                                        Text("Temprature")
                                            .font(.system(size: 25, weight: .medium, design: .rounded))
                                            .tracking(2.0)
                                            .padding(12)
                                            .frame(width: 360, alignment: .leading)
                                            .foregroundStyle(.black.opacity(0.65)) //0x26201b
                                            .background(Color(hex: 0xaeaeb2)) // Background for Name Label
                                            .cornerRadius(32, corners: [.topLeft, .topRight])
                                        //  MARK: ADJUSTING THE LABEL
                                            .offset(x: 5, y: -10)
                                        
                                        // Details about day & year
                                        VStack(alignment: .leading, spacing: 18) {
                                            
                                            //  Year
                                            HStack(alignment: .center) {
                                                Spacer()
                                                
                                                Image(systemName: "thermometer.high")
                                                    .font(.system(size: 60))
                                                    .foregroundColor(Color(hex: 0xe5e5ea))
                                                
                                                Spacer()
                                                
                                                Text("\(planet.temperature ?? 0)")
                                                    .font(.system(size: 35))
                                                    .foregroundColor(Color(hex: 0xe5e5ea))
                                                Spacer()
                                            }
                                        }
                                        .padding(.horizontal, -1) // Padding for the Time content inside the box
                                    }
                                    .padding(29) // Padding for all the content inside the box
                                    
                                } // End of ZStack 3
                            } // End of VStack 3
                        }
                          .offset(y: -10)
                        
                        //  MARK: More Information
                        VStack(alignment: .leading) {
                            ZStack {
                                // Background with rounded corners
                                RoundedRectangle(cornerRadius: 32)
                                    .fill(Color.white.opacity(0.22))
                                    .frame(width: 360, height: 300)
                                    .shadow(color: .black.opacity(0.25), radius: 2, x:0, y:2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 32)
                                            .stroke(Color(hex: 0xd1d1d6), lineWidth: 1)
                                    )
                                
                                // Overlay content - Name box
                                VStack(alignment: .leading) {
                                    // Time Label on top
                                    Text("Additional Details")
                                        .font(.system(size: 25, weight: .medium, design: .rounded))
                                        .tracking(2.0)
                                        .padding(12)
                                        .frame(width: 360, alignment: .leading)
                                        .foregroundStyle(.black.opacity(0.65)) //0x26201b
                                        .background(Color(hex: 0xaeaeb2)) // Background for Name Label
                                        .cornerRadius(32, corners: [.topLeft, .topRight])
                                    //  MARK: ADJUSTING THE LABEL
                                        .offset(x: 5, y: -40)
                                    
                                    // Details about radius,...
                                    VStack(alignment: .leading, spacing: 18) {
                                        //  Radius HStack
                                        HStack() {
                                            Image(systemName: "scale.3d")
                                                .font(.system(size: 22))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Text("radius")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Spacer()
                                            
                                            Text("\(planet.radius ?? 0)")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                        }
                                        
                                        //  distance light year HStack
                                        HStack() {
                                            Image(systemName: "light.overhead.right.fill")
                                                .font(.system(size: 22))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Text("distance light year")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Spacer()
                                            
                                            Text("\(planet.distance_light_year ?? 0)")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                        }
                                        
                                        //  Host star mass HStack
                                        HStack() {
                                            
                                            Image(systemName: "moon.stars")
                                                .font(.system(size: 22))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Text("host start mass")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Spacer()
                                            
                                            Text("\(planet.host_star_mass ?? 0)")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                        }
                                        
                                        //  Host star temperature HStack
                                        HStack() {
                                            
                                            Image(systemName: "thermometer.sun.fill")
                                                .font(.system(size: 22))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Text("host start temperature")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Spacer()
                                            
                                            Text("\(planet.host_star_temperature ?? 0)")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                        }
                                    }
                                    .padding(.horizontal, 20) // Padding for the Time content inside the box
                                }
                                .padding(29) // Padding for all the content inside the box
                                
                            } // End of ZStack 3
                        }
//                        .offset(y: 40)
                        
                    }
                }
            }// (I) End Of VSTACK2 - GENERAL INFO
            //  Highlighting the box
            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
            .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.11), radius: 6, x: 0, y: 8)
            
            //  MARK: Uncomment this to fetch data
            .onAppear {
                infoAPI.fetchSolarSystemPlanets() // Call the API on view load
            }
        }
    }
}

//  MARK: - BACKGROUND COLOR THEME
var BGM_Color: some View {
    ZStack{}
        .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
        .background(LinearGradient(gradient:
                                    Gradient(stops: [.init(color: Color(hex: 0x303030), location: CGFloat(0)), .init(color: Color(hex: 0x232323), location: CGFloat(0.518310546875)), .init(color: Color(hex: 0x202020), location: CGFloat(1))])
                                   , startPoint: UnitPoint(x: 0, y: 0.49999999999999994), endPoint: UnitPoint(x: 1, y: 0.5))
            .ignoresSafeArea())
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
}

//  MARK: - Preview
#Preview {
    PlanetInfoView(viewModel: PlanetViewModel())
}
