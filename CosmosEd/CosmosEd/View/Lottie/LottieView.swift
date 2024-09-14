//
//  LottieView.swift
//  CosmosEd

import SwiftUI
import Lottie

// A SwiftUI wrapper to display Lottie animations
struct LottieView: UIViewRepresentable {
    
    // MARK: PROPERTIES - Lotties' Animation Properties
    let name: String
    let loopMode: LottieLoopMode
    let animationSpeed: CGFloat
    let contentMode: UIView.ContentMode = .scaleAspectFit
    
    // MARK: FUNCTION - Creates the UIView with the Lottie animation
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)         // Empty container view
        let animationView = LottieAnimationView() // Lottie view instance
        let animation = LottieAnimation.named(name) // Load the animation
        
        // Configure the animation view
        animationView.animation = animation
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play()  // Start the animation
        
        // Add the Lottie view with Auto Layout
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        // Set constraints to match parent view size - HEIGHT & WIDTH
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }
    
    // Updates the UIView (unused in this case)
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
