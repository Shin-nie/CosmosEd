//
//  MediaView.swift
//  CosmosEd
//
//  Created by Hang Vu on 14/9/2024.
//

import SwiftUI

// MARK: - Media View for Videos and Images
struct MediaView: View {
    let imageName: String
    var iconOverlay: String? = nil
    var cornerRadius: CGFloat = 60 // New property for dynamic corner radius
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .opacity(0.7)
                .aspectRatio(contentMode: .fill)
                .frame(width: 360, height: 200)
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color(hex: 0xc7c7cc), lineWidth: 1)
                )
                .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
                .padding()
            
            if let iconOverlay = iconOverlay {
                Image(systemName: iconOverlay)
                    .font(.system(size: 50, weight: .regular))
                    .foregroundStyle(Color(UIColor.systemGray4))
            }
        }
        .padding(.top, -20)
    }
}

//  MARK: - Previews
#Preview {
    MediaView(imageName: "mercuryNasa", iconOverlay: "arrowtriangle.forward.circle.fill")
}
