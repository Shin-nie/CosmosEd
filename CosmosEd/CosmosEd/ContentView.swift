//
//  ContentView.swift
//  CosmosEd

import SwiftUI
let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let window = windowScene?.windows.first
let safeAreaTop = window?.safeAreaInsets.top
let safeAreaBottom = window?.safeAreaInsets.bottom

struct ContentView: View {
    @State var geo1: CGSize = .zero
    @State var geo2: CGSize = .zero
    @State var geo: CGSize = .zero
    @State private var selection_mhx: String = "X Axis"
    
    var body: some View {
        VStack {
            // Header
            VStack {
                Text("COSMOSED")
                    .font(.custom("SFProRounded-Medium", size: 24))
                    .foregroundStyle(.white)
                    .tracking(5.0)
                    .frame(height: 32, alignment: .center)
                    .opacity(0.85)
                    .multilineTextAlignment(.center)
                    .padding(.top, safeAreaTop)
                    .padding(.bottom, 12)
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
                        //                        .padding(.top, 35)
                        
                        // Scroll the planets horizontally
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                planetCard(planetName: "Mercury", imageName: "Mercury", textOffset: 0, imageSize: 300)
                                planetCard(planetName: "Venus", imageName: "Venus", textOffset: 0, imageSize: 300)
                                planetCard(planetName: "Earth", imageName: "Earth", textOffset: 0, imageSize: 300)
                            }
                        }
                    }
                }
                
                // Bottom Menu
                VStack(alignment: .leading, spacing: 12) {
                    
                    //  MARK: Home
                    bottomMenuItem(title: "Home", systemImageName: "house.fill")
                    
                    //  MARK: NAVIGATE TO GENRAL INFORMATION - "PlanetDetailView"
                    // Wrap "General Information" with NavigationLink
                    NavigationLink(destination: PlanetDetailView()) {
                        bottomMenuItem(title: "Planet Information", systemImageName: "aqi.medium")
                    }
                  
                    
                    NavigationLink(destination: QuizView() ) {
                        bottomMenuItem(title: "Game", systemImageName: "gamecontroller")

                    }
                    
                    bottomMenuItem(title: "Favorite", systemImageName: "heart.fill")
                }
                //  FORMATTING THE NAVIGATION BUTTON SO IT DOES NOT BLUE
                .buttonStyle(PlainButtonStyle()) // Prevents the automatic blue tint on NavigationLink
                .foregroundColor(.black) // Set your preferred color here
                
                //  PADDING each box
                .padding(.horizontal, 30)
                .padding(.top, 30)
                .padding(.bottom, 80)
                .background(Color.white.opacity(0.8))
                .cornerRadius(24, corners: [.topRight, .topLeft])
                .offset(y: 40)
            }
            
        }
        .background(
            LinearGradient(gradient: Gradient(stops: [.init(color: .black, location: 0), .init(color: Color(hex: 0xc7cccd), location: 0.97)]),
                           startPoint: .top, endPoint: .bottom)
        )
        .ignoresSafeArea(edges: .all)
    }
    
    // Function to generate a planet card
    func planetCard(planetName: String, imageName: String, textOffset: CGFloat, imageSize: CGFloat) -> some View {
        VStack {
            Text(planetName)
                .font(.custom("SFProDisplay-Regular", size: 17))
                .foregroundStyle(.white)
                .opacity(0.3)
                .frame(maxWidth: .infinity, alignment: .center)
                .offset(y: textOffset)
            
            
            Image(imageName)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.15), radius: 10, x: 0, y: -16)
                .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.25), radius: 5, x: 0, y: 2)
                .offset(x: -10, y: 0)
        }
        .frame(width: 406, alignment: .center)
    }
    
    // Function to generate a bottom menu item
    func bottomMenuItem(title: String, systemImageName: String) -> some View {
        HStack() {
            Text(title)
                .font(.custom("SFProRounded-Medium", size: 16))
            Spacer()
            Image(systemName: systemImageName)
                .font(.system(size: 20, weight: .medium))
                .frame(width: 24, height: 24)
        }
        .padding(.horizontal, 20)
        .frame(height: 44, alignment: .center)
        .background(Color.black.opacity(0.1))
        .cornerRadius(12)
    }
}

//  MARK: - Color
extension Color {
    init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

// MARK: Allows for percentage based layouts
struct SizeCalculator: ViewModifier {
    @Binding var size: CGSize
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear { size = proxy.size }
            }
        )
    }
}

// MARK: Enables setting individual vales per corner
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//  MARK: - EXTENSION VIEW
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

extension View {
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}

//  MARK: - PREVIEW
#Preview {
    NavigationStack {
        ContentView()
    }
}
