//
//  ImageView.swift
//  CosmosEd
//
//  Created by Hang Vu on 11/9/2024.
//

import SwiftUI

struct ImageView: View {
    //  MARK: - Properties
    
    //  MARK: - BODY
    var body: some View {
        ZStack {
            BGM_Color
            
            //  MARK: - VIDEO
            ScrollView(.vertical) {
                
                VStack (alignment: .leading) {
                    //  DISPLAYING TITLE'S LABEL
                    HStack(spacing: 5) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                            .padding(.trailing, 8)
                        
                        
                        Text("Images")
                            .font(.system(size: 27, weight: .medium, design: .rounded))
                            .tracking(2.00)
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color(hex: 0x8e8e93))
                        //                        Spacer()
                    }// HSTACK 1
                    .padding()
                    
                        Image("MercuryImage")
                            .resizable()
                            .opacity(0.7)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 360, height: 200)
                            .cornerRadius(60)
                            .overlay(
                                RoundedRectangle(cornerRadius: 60)
                                    .stroke(Color(hex: 0xc7c7cc), lineWidth: 1)
                            )
                            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
                            .padding()
                       
                }// End Of VStack 2
                
            }// (I) End Of ScrollView
            //  Highlighting the box
            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
            .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.11), radius: 6, x: 0, y: 8)
            
        }
    }
}

//  MARK: - Previews
#Preview {
    ImageView()
}
