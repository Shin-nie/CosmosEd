//
//  Test2.swift
//  CosmosEd


import SwiftUI

struct PlanetDetailView: View {
    //  MARK: - Properties
    @ObservedObject var infoAPI: InfoAPI // Fetch Planet data
    @ObservedObject var viewModel: PlanetViewModel   //  Viewmodel to track selected planet

    
    //  MARK: - INITALISATION
    init(infoAPI: InfoAPI, viewModel: PlanetViewModel ){
        
        //  Initialise viewModel
        self.viewModel = viewModel
        self.infoAPI = infoAPI
        
        // TO TRANSPARENT THE NAVIAGTION BACKCROUND
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            BGM_Color
            VStack(alignment: .leading) {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    //  MARK: INFORMATION SECTION
                    // NavigationLink wrapping both SectionHeader and GeneralInfoCard
                    NavigationLink(destination: PlanetInfoView(infoAPI: infoAPI, viewModel: viewModel)) {
                        VStack {
                            SectionHeader(iconName: "info.circle", title: "General Information", trailingIconName: "chevron.forward" )
                                .padding(.horizontal, 10)
                            
                            if infoAPI.planets.isEmpty {
                                
                                Text("Loading Planets...")
                                    .font(.title)
                                    .padding()
                                    .foregroundStyle(Color(hex: 0xc7c7cc))
                                
                            } else {
                                if let selectedPlanet = infoAPI.planets.first(where: { $0.name == viewModel.currentPlanet }) {
                                    GeneralInfoCard(planet: selectedPlanet)
                                    //                            } else {
                                    //                                Text("No planet data available")
                                    //                                    .foregroundColor(.red)
                                    //                                    .font(.title)
                                    //                                    .padding()
                                    //                            }
                                }
                            }
                        }
                    }
                    
                    divider
                    
                    //  MARK: VIDEO SECTION
                    // Videos Section
                    
                    //  MARK: nho pass viewModel lai dang hoang
                    NavigationLink(destination: VideoView(viewModel: viewModel)) {
                        VStack {
                            SectionHeader(iconName: "play.rectangle.fill", title: "Videos", trailingIconName: "chevron.forward")
                            MediaView(imageName: "mercuryNasa", iconOverlay: "arrowtriangle.forward.circle.fill")
                        }
                    }
                    
                    divider
                    
                    //  MARK: IMAGE SECTION
                    // Images Section
                    NavigationLink (destination: ImageView(viewModel: viewModel)) {
                        VStack {
                            SectionHeader(iconName: "photo.on.rectangle.angled", title: "Image", trailingIconName: "chevron.forward")
                            MediaView(imageName: "MercuryImage")
                        }
                    }
                }// End of ScrollView
                
                //  MARK: Uncomment this to fetch data
                .onAppear {
                    infoAPI.fetchSolarSystemPlanets() // Call the API on view load
                }
            }// End of VStack
        }// End of ZStack
    }
    
    // MARK: - Reusable Divider
    var divider: some View {
        VStack {}
            .frame(width: 360, height: 0.6)
            .background(Color(hex: 0xaeaeb2))
            .padding(.vertical, 15)
        //            .padding()
    }
    
    // MARK: - Background Color Theme
    var BGM_Color: some View {
        ZStack {}
            .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(hex: 0x303030), location: 0),
                    .init(color: Color(hex: 0x232323), location: 0.518),
                    .init(color: Color(hex: 0x202020), location: 1)
                ]),
                startPoint: .leading,
                endPoint: .trailing)
                .ignoresSafeArea())
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
    }
}

// MARK: - General Info Card
struct GeneralInfoCard: View {
    
    //  MARK: Accept a Planet object instead of hardcoded value
    let planet: Planet
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color.white.opacity(0.22))
                    .frame(width: 230, height: 156)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(Color(hex: 0xd1d1d6), lineWidth: 1)
                    )
                
                VStack(alignment: .leading) {
                    Text(planet.name)
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .tracking(2.0)
                        .padding(12)
                        .frame(width: 230, alignment: .leading)
                        .foregroundStyle(.black.opacity(0.65))
                        .background(Color(hex: 0xaeaeb2))
                        .cornerRadius(32, corners: [.topLeft, .topRight])
                        .offset(y: -15)
                    
                    VStack(alignment: .leading, spacing: 18) {
                        InfoRow(iconName: "scalemass.fill", label: "mass", value: "\(planet.mass ?? 0)")
                        InfoRow(iconName: "circle.dotted.and.circle", label: "Period", value: "\(planet.period ?? 0)")
                    }
                    .padding(.horizontal, 8)
                }
                .padding(12)
            }
            Image(planet.name)
                .resizable()
                .frame(width: 130, height: 130)
                .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.22), radius: 34, x: 0, y: -16)
                .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.25), radius: 24, x: 0, y: 2)
                .offset(x: -10)
        }
        .padding()
    }
}

// MARK: - InfoRow for Mass and Period
struct InfoRow: View {
    let iconName: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.system(size: 22))
                .foregroundColor(Color(hex: 0xe5e5ea))
            
            Text(label)
                .font(.system(size: 17))
                .foregroundColor(Color(hex: 0xe5e5ea))
            
            Spacer()
            Text(value)
                .font(.system(size: 17))
                .foregroundColor(Color(hex: 0xe5e5ea))
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PlanetDetailView(infoAPI: InfoAPI(),viewModel: PlanetViewModel())
    }
}
