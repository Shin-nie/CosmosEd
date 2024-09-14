//
//  ContentView.swift
//  CosmosEd

//  MARK: To achieve dynamic text updates while scrolling, need to detect the visible planet in the ScrollView. A common approach is to use a GeometryReader to check when a planet is close to the center of the view and update the currentPlanet accordingly.


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
    
    
    // state variables for interactive Image
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .degrees(0)
    @State private var isTapped = false
    @State private var floatingOffset: CGFloat = 0.0
    @State private var floatingDirection: Bool = true // To toggle direction

    
    
    @ObservedObject var planetVM: PlanetViewModel;
    
    //  MARK: Use GeometryReader to track the position of each planet card.
    //  Update PlanetViewModel‘s currentPlanet based on the card’s position relative to the ScrollView
    //  @State private var scrollOffset: CGFloat = 0.0
    
    
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
                        
                        //  MARK: DISPLAY CURRENT PLANET
                        Text(planetVM.currentPlanet)
                            .font(.custom("SFProDisplay-Regular", size: 17))
                            .foregroundStyle(.white)
                            .opacity(0.3)
                            .frame(maxWidth: .infinity, alignment: .center)
//                            .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                        
                        // Scroll the planets horizontally
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(planetVM.planets) { planet in
                                    GeometryReader { geo in
                                        planetCard(planet: planet)
                                            .onChange(of: geo.frame(in: .global).midX) { newX in
                                                updateCurrentPlanet(for: planet, geo: geo)
                                            }
                                    }
                                    .frame(width: 390, height: 400) // Set frame for each card
                                }
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
                    NavigationLink(destination: PlanetDetailView(infoAPI: InfoAPI(), viewModel: planetVM)) {
                        bottomMenuItem(title: "Planet Information", systemImageName: "aqi.medium")
                    }
                    
                    
                    NavigationLink(destination: IntroView2() ) {
                        bottomMenuItem(title: "Flashcard", systemImageName: "greetingcard")
                        
                    }
                    
                    NavigationLink(destination: AllPlanet(infoAPI: InfoAPI(), viewModel: PlanetViewModel())) {
                        bottomMenuItem(title: "All Planets", systemImageName: "bubbles.and.sparkles.fill")
                        
                    }
                    
                    //  bottomMenuItem(title: "Favorite", systemImageName: "heart.fill")
                    
                }
                //  FORMATTING THE NAVIGATION BUTTON SO IT DOES NOT BLUE
                .buttonStyle(PlainButtonStyle()) // Prevents the automatic blue tint on NavigationLink
                .foregroundColor(.black) // Set your preferred color here
                
                //  PADDING each box
                .padding(.horizontal, 30)
                .padding(.top, 30)
                .padding(.bottom, 30) // The sheet height
                .background(Color.white.opacity(0.8))
                .cornerRadius(24, corners: [.topRight, .topLeft])
            }
            
        }
        .background(
            LinearGradient(gradient: Gradient(stops: [.init(color: .black, location: 0), .init(color: Color(hex: 0xc7cccd), location: 0.97)]),
                           startPoint: .top, endPoint: .bottom)
        )
        .ignoresSafeArea(edges: .all)
    }
    
    
    // MARK: Function to update the current planet name based on scroll position
        func updateCurrentPlanet(for planet: Planet, geo: GeometryProxy) {
            let screenWidth = UIScreen.main.bounds.width
            let cardMidX = geo.frame(in: .global).midX
            let screenCenterX = screenWidth / 2
            
            // The closer the cardMidX is to the screenCenterX, the more centered it is
            if abs(cardMidX - screenCenterX) < 100 { // Tweak this value if needed
                if planetVM.currentPlanet != planet.name {
                    planetVM.updateCurrentPlanet(to: planet)
                    print(planetVM.currentPlanet);
                }
            }
        }
    
    // Function to generate a planet card with gestures applied to the image
    func planetCard(planet: Planet) -> some View {
        VStack {
            Image(planet.assetImageName)
                .resizable()
                .frame(width: 300, height: 300)
                .scaleEffect(scale) // Apply scale effect
                .rotationEffect(rotation) // Apply rotation effect
                .offset(y: floatingOffset) // Apply vertical floating effect
                .onAppear {
                    startFloating() // Start the floating effect when the image appears
                }
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scale = value // Pinch-to-zoom gesture
                        }
                )
                .simultaneousGesture(
                    RotationGesture()
                        .onChanged { angle in
                            rotation = angle // Rotation gesture
                        }
                )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isTapped.toggle()
                        scale = isTapped ? 1.2 : 1.0 // Animate scale on tap
                    }
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred() // Haptic feedback on tap
                }
                .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.15), radius: 10, x: 0, y: -16)
                .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.25), radius: 5, x: 0, y: 2)
        }
        .frame(width: 380, alignment: .center)
        .offset(y: 60)
    }

    // Function to start the floating effect
    func startFloating() {
        withAnimation(
            Animation.easeInOut(duration: 1.5)
                .repeatForever(autoreverses: true)
        ) {
            floatingOffset = floatingDirection ? -15 : 15 // Switch between floating up and down
            floatingDirection.toggle() // Toggle direction for next animation
        }
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
        ContentView(planetVM: PlanetViewModel())
    }
}
