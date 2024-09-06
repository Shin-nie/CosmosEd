//
//  Test.swift
//  CosmosEd
//
//  Created by Hang Vu on 6/9/2024.
//

import SwiftUI

struct Test: View {
    var body: some View {
        VStack {
            // MARK: GENERAL INFORMATION
            HStack(spacing: 5) {
                Image(systemName: "info.circle")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(Color(hex: 0xc7c7cc))
                
                Text("General Information")
                    .font(.system(size: 30, weight: .medium, design: .rounded))
                    .tracking(2.00)
                    .foregroundStyle(Color(hex: 0xc7c7cc))
                
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(Color(hex: 0x8e8e93))
            }
            .padding(.horizontal)
            
            // TIME SECTION
            HStack {
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
                        
                        // Overlay content
                        VStack(alignment: .leading) {
                            Text("Time")
                                .font(.custom("SFProRounded-Medium", size: 28))
                                .foregroundColor(Color(hex: 0x26201b))
                                .padding(.top, 12)
                            
                            Spacer()
                            
                            HStack(spacing: 1) {
                                Image(systemName: "hourglass")
                                    .font(.system(size: 22))
                                    .foregroundColor(Color(hex: 0xe5e5ea))
                                Text("Length of day")
                                    .font(.custom("SFProRounded-Regular", size: 17))
                                    .foregroundColor(Color(hex: 0xe5e5ea))
                            }
                            
                            Text("24.65 hrs")
                                .font(.custom("SFProRounded-Regular", size: 16))
                                .foregroundColor(Color(hex: 0xe5e5ea))
                                .padding(.bottom, 10)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "bubbles.and.sparkles")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color(hex: 0xe5e5ea))
                                Text("Length of year")
                                    .font(.custom("SFProRounded-Regular", size: 17))
                                    .foregroundColor(Color(hex: 0xe5e5ea))
                            }
                            
                            Text("0.0341")
                                .font(.custom("SFProRounded-Regular", size: 16))
                                .foregroundColor(Color(hex: 0xe5e5ea))
                        }
                        .padding(.horizontal, 10)
                        .frame(width: 230, height: 156, alignment: .leading)
                    }
                }
                
                Spacer()
                
                // Planet image
                Image("Mercury")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    Test()
}
