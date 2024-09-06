//
//  PlanetDetailView.swift
//  CosmosEd

import SwiftUI

import SwiftUI
struct PlanetDetailView: View {
    
    //  MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            // Spacer()
            
            ScrollView(.vertical, showsIndicators: false) {
                //  MARK: - GENERAL INFORMATION
                VStack(alignment: .leading) {
                    //  DISPLAYING TITLE'S LABEL
                    HStack(spacing: 5) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                            .padding(.trailing, 8)
                        
                        
                        Text("General Information")
                            .font(.system(size: 27, weight: .medium, design: .rounded))
                            .tracking(2.00)
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color(hex: 0x8e8e93))
                        
                        Spacer()
                        
                    }// HSTACK 1
                    .padding()
                    
                    //  TIME SECTION
                    HStack {
                        VStack {
                            ZStack {
                                // Background with rounded corners
                                RoundedRectangle(cornerRadius: 32)
                                    .fill(Color.white.opacity(0.22))
                                    .frame(width: 230, height: 156)
                                    .shadow(color: .black.opacity(0.25), radius: 2, x:0, y:2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 32)
                                            .stroke(Color(hex: 0xd1d1d6), lineWidth: 1)
                                    )
                                
                                // Overlay content
                                VStack(alignment: .leading) {
                                    // Time Label on top
                                    Text("Time")
                                        .font(.system(size: 28, weight: .medium, design: .rounded))
                                        .tracking(2.0)
                                        .padding(12)
                                        .frame(width: 230, alignment: .leading)
                                        .foregroundStyle(Color(hex: 0x26201b))
                                        .background(Color(hex: 0xaeaeb2)) // Background for Time Label
                                        .cornerRadius(32, corners: [.topLeft, .topRight])
                                    //  MARK: ADJUSTING THE "TIME" LABEL
                                        .offset(y: -12)
                                    
                                    // Details about day & year
                                    VStack(alignment: .leading, spacing: 18) {
                                        //  Day
                                        HStack {
                                            Image(systemName: "hourglass")
                                                .font(.system(size: 22))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Text("Length of day")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Spacer()
                                            
                                            Text("24.65 hrs")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                        }
                                        
                                        //  Year
                                        HStack {
                                            Image(systemName: "bubbles.and.sparkles")
                                                .font(.system(size: 22))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Text("Length of year")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                            
                                            Spacer()
                                            
                                            Text("0.0341")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color(hex: 0xe5e5ea))
                                        }
                                    }
                                    .padding(.horizontal, 8) // Padding for the Time content inside the box
                                }
                                .padding(12) // Padding for all the content inside the box
                            } // End of ZStack 3
                        } // End of VStack 3
                        
                        Image("Mercury")
                            .resizable()
                            .frame(width: 130, height: 130)
                            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.22), radius: 34, x: 0, y: -16)
                            .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.25), radius: 24, x: 0, y: 2)
                            .offset(x: -10, y: 0)
                        
                    }// HStack 2
                }// (I) End Of VSTACK2 - GENERAL INFO
                
                //  MARK: - Divider
                divider
                
                //  MARK: - VIDEOS
                VStack(alignment: .leading) {
                    //  DISPLAYING TITLE'S LABEL
                    HStack(spacing: 5) {
                        Image(systemName: "play.rectangle.fill")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                            .padding(.trailing, 8)
                        
                        Text("Videos")
                            .font(.system(size: 27, weight: .medium, design: .rounded))
                            .tracking(2.00)
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                        
                        Spacer()
                        
            
                        Image(systemName: "chevron.forward")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color(hex: 0x8e8e93))
                        
//                        Spacer()
                        
                    }// End Of HSTACK 1 - Title's Label
                    .padding()
                    .padding(.top, -40)
                    
                    //  DISPLAYING VIDEO
                    ZStack {
                        Image("mercuryNasa")
                            .resizable()
                            .opacity(0.7) // Set the opacity here (0.5 means 50% opacity)
                            .aspectRatio(contentMode: .fill) // Fill the available space while maintaining the aspect ratio
                            .frame(width: 360, height: 200) // You can adjust the width and height to fit the container
                            .cornerRadius(60) // Ensure the image is clipped to the same rounded shape
                            .overlay(
                                RoundedRectangle(cornerRadius: 60)
                                    .stroke(Color(hex: 0xc7c7cc), lineWidth: 1)
                            )
                            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                            .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.11), radius: 6, x: 0, y: 8)
                            .padding()
                        
                        Image(systemName: "arrowtriangle.forward.circle.fill")
                            .font(.system(size: 50, weight: .regular))
                            .frame(alignment: .center)
                            .foregroundStyle(Color(UIColor.systemGray4))
                    }
                    .padding(.top, -20)
                    
                }// (I) End Of VSTACK3 - VIDEOS
                
                //  MARK: - Divider
                divider
                    .offset(y: -15)
                
                //  MARK: - IMAGES
                VStack(alignment: .leading) {
                    //  DISPLAYING TITLE'S LABEL
                    HStack(spacing: 5) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                            .padding(.trailing, 8)
                        
                        Text("Image")
                            .font(.system(size: 27, weight: .medium, design: .rounded))
                            .tracking(2.00)
                            .foregroundStyle(Color(hex: 0xc7c7cc))
                        
                        Spacer()
                        
            
                        Image(systemName: "chevron.forward")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color(hex: 0x8e8e93))
                        
//                        Spacer()
                        
                    }// End Of HSTACK 1 - Title's Label
                    .padding()
                    .padding(.top, -40)
                    
                    //  DISPLAYING VIDEO
                    ZStack {
                        Image("MercuryImage")
                            .resizable()
                            .opacity(0.7) // Set the opacity here (0.5 means 50% opacity)
                            .aspectRatio(contentMode: .fill) // Fill the available space while maintaining the aspect ratio
                            .frame(width: 360, height: 200) // You can adjust the width and height to fit the container
                            .cornerRadius(60) // Ensure the image is clipped to the same rounded shape
                            .overlay(
                                RoundedRectangle(cornerRadius: 60)
                                    .stroke(Color(hex: 0xc7c7cc), lineWidth: 1)
                            )
                            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                            .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.11), radius: 6, x: 0, y: 8)
                            .padding()
                    }
                    .padding(.top, -20)
                    
            }// (I) End Of VSTACK4 - IMAGES
            }
            // Spacer()
        }// (O) End Of main VStack1
        //  Background-Color Theme
        .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
        .background(LinearGradient(gradient:
                                    Gradient(stops: [.init(color: Color(hex: 0x303030), location: CGFloat(0)), .init(color: Color(hex: 0x232323), location: CGFloat(0.518310546875)), .init(color: Color(hex: 0x202020), location: CGFloat(1))])
                                   , startPoint: UnitPoint(x: 0, y: 0.49999999999999994), endPoint: UnitPoint(x: 1, y: 0.5))
            .ignoresSafeArea())
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
    }
    
    //  MARK: - DISPLAY DIVIDER LINE
    var divider: some View{
        VStack {}
            .frame(width: 360, height: 0.6)
            .background(Color(hex: 0xaeaeb2))
            .padding(.vertical, 20)
            .padding()
        //  .offset(x: 3, y: -145)
    }
    
    //  MARK: - BACKGROUND COLOR THEME
    var BGM_Color: some View {
        ZStack{}
    }
    
    
}

//  MARK: - Preview
#Preview {
    PlanetDetailView()
}
