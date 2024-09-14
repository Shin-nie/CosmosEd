//
//  SectionHeader.swift
//  CosmosEd

import SwiftUI

// MARK: - Section Header
struct SectionHeader: View {
    let iconName: String
    let title: String
    let trailingIconName: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: iconName)
                .font(.system(size: 23, weight: .bold))
                .foregroundStyle(Color(hex: 0xc7c7cc))
                .padding(.trailing, 8)
            
            Text(title)
                .font(.system(size: 27, weight: .medium, design: .rounded))
                .tracking(2.00)
                .foregroundStyle(Color(hex: 0xc7c7cc))
            
            Spacer()
            Image(systemName: trailingIconName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color(hex: 0x8e8e93))
        }
        .padding(.horizontal, 8)
        .padding()
    }
}

#Preview {
    SectionHeader(iconName: "info.circle", title: "General Information", trailingIconName: "chevron.forward" )
}
