import SwiftUI
import CoreMotion

struct WelcomeView: View {
    @State private var isAnimating = false
    @State private var parallaxOffset: CGFloat = 0
    let motionManager = CMMotionManager()

    var body: some View {
        ZStack {
            // Animated stars background
            movingStarsBackground
            
            VStack(spacing: 0) {
                welcomeTitle
                    .offset(x: parallaxOffset, y: parallaxOffset)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut(duration: 1.5), value: isAnimating)
                
                LottieView(name: Constants.cosmosAnimation, loopMode: .loop, animationSpeed: 0.7)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 20)
                    .offset(x: parallaxOffset / 2, y: parallaxOffset / 2)
                
                appDescription
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut(duration: 1.5).delay(0.5), value: isAnimating)
                
                startExploringButton
                    .offset(x: parallaxOffset, y: parallaxOffset)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut(duration: 1.5).delay(1), value: isAnimating)
                    .onTapGesture {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred() // Haptic feedback
                    }
            }
        }
        .onAppear {
            isAnimating = true
            startDeviceMotionUpdates()
        }
        .onDisappear {
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    // Parallax effect using device motion
    private func startDeviceMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1/60
            motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
                if let motion = data {
                    let tiltX = CGFloat(motion.attitude.roll * 10)
                    let tiltY = CGFloat(motion.attitude.pitch * 10)
                    parallaxOffset = tiltX + tiltY
                }
            }
        }
    }
    
    // Starry background
    var movingStarsBackground: some View {
        GeometryReader { geometry in
            ZStack {
                Image("starsBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .ignoresSafeArea()
                    .blur(radius: 10)
                    .opacity(0.5)
                
                // Subtle pulsating light
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .blur(radius: 20)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 4)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
            }
        }
    }

    var welcomeTitle: some View {
        VStack {
            Text("Discover the CosmosEd Universe")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(Color(.systemTeal))
    }
    
    var appDescription: some View {
        Text("Embark on an interactive journey through the cosmos! Learn about planets with exciting visuals and educational content.")
            .font(.subheadline)
            .padding(.bottom, 40)
            .padding(.horizontal)
            .multilineTextAlignment(.center)
    }
    
    var startExploringButton: some View {
        NavigationLink(destination: ContentView(planetVM: PlanetViewModel()).navigationBarBackButtonHidden(true)) {
            HStack {
                Text("START EXPLORING")
                    .fontWeight(.semibold)
                Image(systemName: "wand.and.stars")
            }
            .foregroundStyle(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(Color(.systemTeal))
        .cornerRadius(10)
        .padding(.bottom, 50)
    }
}

#Preview {
    NavigationStack {
        WelcomeView()
    }
}
