import SwiftUI

struct Test: View {
    @State var geo1: CGSize = .zero
    @State var geo2: CGSize = .zero
    @State var geo: CGSize = .zero
    @State private var selection_mhx: String = "X Axis"
    
    // For showing the sheet
    @State private var showBottomMenuSheet = false
    
    var body: some View {
        VStack {
            // Header
            ZStack {
                VStack {
                    Text("COSMOSED")
                        .font(.custom("SFProRounded-Medium", size: 24))
                        .tracking(5.0)
                        .frame(height: 32, alignment: .center)
                        .opacity(0.85)
                        .multilineTextAlignment(.center)
                        .padding(.top, safeAreaTop)
                        .padding(.bottom, 12)
                }
                .background(
                    LinearGradient(gradient: Gradient(stops: [.init(color: .white, location: CGFloat(0)), .init(color: .white.opacity(0), location: CGFloat(1))]),
                                   startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
                )
            }

            // Scroll the tab bar
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    VStack(spacing: 16) {
                        Picker("", selection: $selection_mhx) {
                            ForEach(["Sun", "Mercury", "Venus", "Earth"], id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()

                        // Scroll the planets horizontally
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                planetCard(planetName: "Sun", imageName: "Sun", textOffset: -40, imageSize: 300)
                                planetCard(planetName: "Mercury", imageName: "Mercury", textOffset: -40, imageSize: 300)
                                planetCard(planetName: "Venus", imageName: "Venus", textOffset: -40, imageSize: 300)
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Button to open the bottom menu as a sheet
                Button(action: {
                    showBottomMenuSheet.toggle()
                }) {
                    Text("Open Menu")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showBottomMenuSheet) {
                    BottomMenuView()
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(stops: [.init(color: .white, location: 0), .init(color: Color(hex: 0xc7cccd), location: 0.97)]),
                           startPoint: .top, endPoint: .bottom)
        )
        .ignoresSafeArea(edges: .all)
    }
    
    // Function to generate a planet card
    func planetCard(planetName: String, imageName: String, textOffset: CGFloat, imageSize: CGFloat) -> some View {
        VStack {
            Text(planetName)
                .font(.custom("SFProDisplay-Regular", size: 17))
                .opacity(0.5)
                .frame(maxWidth: .infinity, alignment: .center)
                .offset(y: textOffset)
            
            Image(imageName)
                .resizable()
                .frame(width: imageSize, height: imageSize)
        }
        .frame(width: 406, alignment: .center)
    }
}

// BottomMenuView as a sheet
struct BottomMenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NavigationLink(destination: PlanetDetailView(infoAPI: InfoAPI(), viewModel: PlanetViewModel())) {
                bottomMenuItem(title: "General Information", systemImageName: "aqi.medium")
            }
            bottomMenuItem(title: "Home", systemImageName: "house.fill")
            bottomMenuItem(title: "Game", systemImageName: "gamecontroller")
            bottomMenuItem(title: "Favorite", systemImageName: "heart.fill")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(24, corners: [.topRight, .topLeft])
    }
    
    // Function to generate a bottom menu item
    func bottomMenuItem(title: String, systemImageName: String) -> some View {
        HStack {
            Text(title)
                .font(.custom("SFProRounded-Medium", size: 16))
            Spacer()
            Image(systemName: systemImageName)
                .font(.system(size: 20, weight: .medium))
                .frame(width: 24, height: 24)
        }
        .padding()
        .frame(height: 44, alignment: .center)
        .background(Color.black.opacity(0.1))
        .cornerRadius(12)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Test()
        }
    }
}
